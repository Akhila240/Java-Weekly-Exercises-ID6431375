package VerifyingInstructionsdemo.src.test.java.com.example;


import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

public class MyServiceTest {

    @Test
    public void testVerifyInteractionWithArgument() {
        // 1. Create mock
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);

        // 2. Inject mock into service
        MyService service = new MyService(mockApi);

        // 3. Call method
        service.fetchData();

        // 4. Verify interaction with correct argument
        verify(mockApi).getData("users");
    }
}
