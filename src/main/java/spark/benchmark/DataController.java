package spark.benchmark;

import spark.Request;
import spark.Response;
import spark.Spark;

public class DataController {
    DataService service;

    public DataController(DataService service) {
        this.service = service;
        Spark.get("/data", this::getData);
        SparkAsync.getAsync("/asyncdata", this::getData);
    }

    private String getData(Request req, Response resp) throws Exception {
        long delay = 0;
        String delayParam = req.queryParams("delay");
        if (delayParam != null) {
            delay = Long.parseLong(delayParam);
        }
        return service.getData(delay);
    }
}
