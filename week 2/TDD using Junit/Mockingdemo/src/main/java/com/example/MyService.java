package Mockingdemo.src.main.java.com.example;

public class MyService {
    private ExternalAPI api;

    public MyService(ExternalAPI api) {
        this.api = api;
    }

    public boolean processData() {
        String data = api.fetchData();
        return data != null && !data.isEmpty();
    }
}
