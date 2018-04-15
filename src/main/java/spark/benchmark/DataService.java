package spark.benchmark;

public class DataService {
    public String getData(long delay) throws Exception {
        if (delay > 60000) {
            throw new IllegalArgumentException("delay is too long");
        }
        if (delay > 0) {
            Thread.sleep(delay);
        }
        return "done";
    }
}
