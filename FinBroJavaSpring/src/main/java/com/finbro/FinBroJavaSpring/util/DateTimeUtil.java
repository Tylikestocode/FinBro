package com.finbro.FinBroJavaSpring.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

public class DateTimeUtil {

    // Regular expression to match the 'yyyy-MM-dd HH:mm:ss' format
    private static final String DATE_TIME_PATTERN = "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}$";
    private static final Pattern pattern = Pattern.compile(DATE_TIME_PATTERN);

    // DateTimeFormatter for parsing and formatting the date-time string
    public static final String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern(DATE_TIME_FORMAT);

    // Checks if the given String is in the format "yyyy-MM-dd HH:mm:ss"
    public static boolean isValidDateTimeFormat(String dateTimeString) {
        if (dateTimeString == null) {
            return false;
        }
        return pattern.matcher(dateTimeString).matches();
    }

    // Converts a String in the format "yyyy-MM-dd HH:mm:ss" to a LocalDateTime object
    public static LocalDateTime convertStringToDateTime(String dateTimeString) {
        if (!isValidDateTimeFormat(dateTimeString)) {
            return null;
        }
        try {
            return LocalDateTime.parse(dateTimeString, DATE_TIME_FORMATTER);
        }
        catch (DateTimeParseException e) {
            return null;
        }
    }

    // Converts a LocalDateTime object to a String in the format "yyyy-MM-dd HH:mm:ss"
    public static String convertDateTimeToString(LocalDateTime dateTime) {
        if (dateTime == null) {
            return null;
        }
        return dateTime.format(DATE_TIME_FORMATTER);
    }

}
