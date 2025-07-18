// AssertionsTest.java

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class AssertionsTest {

    @Test
    public void testAssertions() {
        assertEquals(5, 2 + 3);
        assertTrue(5 > 3);
        assertFalse(5 < 3);
        assertNull(null);
        assertNotNull(new Object());
    }

    // Main method to trigger test manually (not typical JUnit, just for plain Java run)
    public static void main(String[] args) {
        AssertionsTest test = new AssertionsTest();
        test.testAssertions();
        System.out.println("All assertions passed.");
    }
}
