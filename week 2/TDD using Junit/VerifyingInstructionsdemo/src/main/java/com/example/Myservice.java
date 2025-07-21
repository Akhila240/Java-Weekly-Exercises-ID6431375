package VerifyingInstructionsdemo.src.main.java.com.example;

 class MyService{
    private ExternalApi api;

    public MyService(ExternalApi api) {
        this.api = api;
    }

    public void fetchData() {
        api.getData("users");  // This method call will be verified
    }
}
