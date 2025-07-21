package Mockingdemo.src.test.java.com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    public void testProcessDataReturnsTrueWhenDataIsNotEmpty() {
        ExternalAPI mockAPI = mock(ExternalAPI.class);
        when(mockAPI.fetchData()).thenReturn("mocked data");

        MyService service = new MyService(mockAPI);
        assertTrue(service.processData());
        
    }
}
