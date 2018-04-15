package spark.benchmark;

public class Application {
    public static void main(String[] args) {
        DataService dataService = new DataService();
        DataController dataController = new DataController(dataService);
    }
}
