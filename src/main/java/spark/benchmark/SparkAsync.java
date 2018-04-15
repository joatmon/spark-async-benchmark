package spark.benchmark;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.Route;
import spark.RouteImpl;
import spark.Spark;

import javax.servlet.AsyncContext;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class SparkAsync {
    private static final Logger LOG = LoggerFactory.getLogger("spark.Spark");
    private static final ExecutorService executorService = Executors.newFixedThreadPool(100);

    public static void getAsync(final String path, final Route route) {
         Spark.get(path, (req, resp) -> {
             AsyncContext ctx = req.startAsync();
             ctx.setTimeout(60000);
             CompletableFuture<Object> future = new CompletableFuture<>();
             future.runAsync(() -> {
                 Object result = null;
                 try {
                     result = route.handle(req, resp);
                     future.complete(result);
                     //LOG.info("completed");
                 } catch (Throwable t) {
                     future.completeExceptionally(t);
                     LOG.error("request failed", t);
                 }
             }, executorService);
             future.whenComplete((result, throwable) -> {
                 if (throwable != null) {
                     resp.status(500);
                     resp.body("Error: " + throwable.getMessage());
                     ctx.complete();
                     return;
                 }
                 Object content = "";
                 if (route instanceof RouteImpl) {
                     RouteImpl routeImpl = ((RouteImpl) route);
                     try {
                         content = routeImpl.render(result);
                     } catch (Exception e) {
                         resp.status(500);
                         resp.body("Error: " + e.getMessage());
                         ctx.complete();
                         return;
                     }
                 } else {
                     content = result;
                 }
                 if (content instanceof String) {
                    String contentStr = (String) content;
                    resp.body(contentStr);
                 } else {
                     throw new RuntimeException("unexpected content type");
                 }
                 ctx.complete();
             });
             return "";
         });
    }

}
