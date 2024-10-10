package COMP5361.assignment1;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

// code version 2
public class warmUp {
    private final Map<String, Boolean> truthMap;

    public warmUp() {
        // setup for acceptable inputs Map
        truthMap = new HashMap<>();
        truthMap.put("true", true);
        truthMap.put("t", true);
        truthMap.put("1", true);
        truthMap.put("false", false);
        truthMap.put("f", false);
        truthMap.put("0", false);
    }

    private Boolean negation(boolean value) {
        return !value;
    }

    // user input values output to a String array
    private String[] getUserInput(Scanner scanner) {
        while (true) {
            System.out.print("Enter one or two (space-separated) truth values (True, False, T, F, 0, 1): ");
            String line = scanner.nextLine().trim();
            String[] inputs = line.split("\\s+");
            
            // check for length to be either 1 or 2
            if (inputs.length == 1 || inputs.length == 2) {
                return inputs;
            } else {
                System.out.println("Invalid input: " + line + "\nPlease enter one or two (space-separated) truth values.");
            }
        }
    }

    // find boolean value for string from HashMap
    private String parseBoolean(String input, Scanner scanner) {
        while (true) {
            Boolean value = truthMap.get(input.toLowerCase());
            if (value != null) {
                return input;
            } else {
                System.out.println("Invalid input: " + input + "\nAll values must be either 'True', 'False', 'T', 'F', '0', or '1'.");
                System.out.print("Please enter one or two (space-separated) truth values: ");
                input = scanner.nextLine().trim();
            }
        }
    }

    // format the returned value to be the same as the user input format
    private String getFormat(String original, boolean value) {
        if (original.equalsIgnoreCase("true") || original.equalsIgnoreCase("false")) {
            return value ? "True" : "False";
        } else if (original.equalsIgnoreCase("t") || original.equalsIgnoreCase("f")) {
            return value ? "T" : "F";
        } else if (original.equals("1") || original.equals("0")) {
            return value ? "1" : "0";
        } else {
            throw new IllegalArgumentException("Unexpected format: " + original);
        }
    }
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        warmUp wu = new warmUp();

        String[] values = wu.getUserInput(scanner);
        
        // if only one value is entered execute negation only
        if (values.length == 1) {
            System.out.println("You entered one valid truth value: " + values[0]);

            String validatedInput = wu.parseBoolean(values[0], scanner);
            boolean parsedValue = wu.truthMap.get(validatedInput);
            boolean negatedValue = wu.negation(parsedValue);
            String formatBoolean = wu.getFormat(validatedInput, negatedValue);
            
            System.out.println("The negated value is: " + formatBoolean);

        } else if (values.length == 2) {
            System.out.println("You entered two valid truth values: " + values[0] + " and " + values[1]);
        }
        
        scanner.close();
    }
}