import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class AssertionsTest {

    @Test
    public void testAssertions() {
        assertEquals(5, 2 + 3);          // Assert equals
        assertTrue(5 > 3);               // Assert true
        assertFalse(5 < 3);              // Assert false
        assertNull(null);               // Assert null
        assertNotNull(new Object());     // Assert not null
    }
}
