package AAApatterndemo.src.test.java.com.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorTest {

    private Calculator calculator;

    @BeforeEach
    void setUp() {
        // Arrange: create Calculator before each test
        calculator = new Calculator();
        System.out.println("Setup complete.");
    }

    @AfterEach
    void tearDown() {
        // Teardown: cleanup after each test
        calculator = null;
        System.out.println("Teardown complete.");
    }

    @Test
    void testAdd() {
        // Act
        int result = calculator.add(4, 6);

        // Assert
        assertEquals(10, result, "Addition should return 10");
    }

    @Test
    void testSubtract() {
        // Act
        int result = calculator.subtract(9, 3);

        // Assert
        assertEquals(6, result, "Subtraction should return 6");
    }
}
