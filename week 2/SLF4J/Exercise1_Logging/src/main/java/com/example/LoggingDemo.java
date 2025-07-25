package com.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingDemo {

    // Create a logger for this class
    private static final Logger logger = LoggerFactory.getLogger(LoggingDemo.class);

    public static void main(String[] args) {
        logger.info("Application started");

        logger.warn("This is a warning message");
        logger.error("This is an error message");

        logger.info("Application finished");
    }
}
