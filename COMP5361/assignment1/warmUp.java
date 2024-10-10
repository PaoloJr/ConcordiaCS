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

    private Boolean conjunction(boolean input1, boolean input2) {
        return input1 && input2;
    }

    private Boolean disjunction(boolean input1, boolean input2) {
        return input1 || input2;
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

    private String[] parseBooleans(String[] inputs, Scanner scanner) {
        while (true) {
            // Validate single or double values
            if (inputs.length == 1) {
                String validated = parseSingleBoolean(inputs[0], scanner);
                return new String[]{validated}; // Return a single-element array
            } else if (inputs.length == 2) {
                String[] validated = parseDoubleBoolean(inputs, scanner);
                return validated;
            } else {
                System.out.println("Invalid input. Please enter one or two (space-separated) truth values.");
                inputs = getUserInput(scanner);
            }
        }
    }

    // find boolean value for string from HashMap
    private String parseSingleBoolean(String input, Scanner scanner) {
        while (true) {
            Boolean value = truthMap.get(input.toLowerCase());
            if (value != null) {
                return input;
            } else {
                System.out.println("Invalid input: " + input + "\nAll values must be either 'True', 'False', 'T', 'F', '0', or '1'.");
                // System.out.print("Please enter one or two (space-separated) truth values: ");
                String[] newInputs = getUserInput(scanner);
                input = newInputs[0]; // Update with the new single input
            }
        }
    }

    private String[] parseDoubleBoolean(String[] inputs, Scanner scanner) {
        while (true) {
            String[] validatedInputs = new String[2];
            for (int i = 0; i < inputs.length; i++) {
                Boolean value = truthMap.get(inputs[i].toLowerCase());
                if (value != null) {
                    validatedInputs[i] = inputs[i];
                } else {
                    System.out.println("Invalid input: " + inputs[i] + "\nAll values must be either 'True', 'False', 'T', 'F', '0', or '1'.");
                    inputs = getUserInput(scanner); // Re-prompt for one or two values
                    return parseBooleans(inputs, scanner); // Restart parsing with new input
                }
            }
            return validatedInputs; // Return the validated inputs if both are correct
        }
    }

    // format the returned value to be the same as the user input format
    private String getFormat(String original, boolean value, Scanner scanner) {
        while(true) {
            if (original.equalsIgnoreCase("true") || original.equalsIgnoreCase("false")) {
                return value ? "True" : "False";
            } else if (original.equalsIgnoreCase("t") || original.equalsIgnoreCase("f")) {
                return value ? "T" : "F";
            } else if (original.equals("1") || original.equals("0")) {
                return value ? "1" : "0";
            } else {
                System.out.println("Unexpected format: " + original);
                System.out.print("Please enter a valid format (True, False, T, F, 1, 0): ");
                original = scanner.nextLine().trim();
            }
        }
    }
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        warmUp wu = new warmUp();

        String[] values = wu.getUserInput(scanner);
        String[] validatedInputs = wu.parseBooleans(values, scanner);
        
        // for negation; it requires a single input
        if (values.length == 1) {
            String validatedInput = wu.parseSingleBoolean(values[0], scanner);
            System.out.println("You entered one valid truth value: " + validatedInput);
            
            boolean parsedValue = wu.truthMap.get(validatedInput);
            boolean negatedValue = wu.negation(parsedValue);
            String formattedBoolean = wu.getFormat(validatedInput, negatedValue, scanner);
            
            System.out.println("The negated (NOT) value is: " + formattedBoolean);
            
        // for all other functions; they require two inputs
        } else if (values.length == 2) {
            Boolean parsedValue1 = wu.truthMap.get(validatedInputs[0].toLowerCase());
            Boolean parsedValue2 = wu.truthMap.get(validatedInputs[1].toLowerCase());

            boolean conjunction = wu.conjunction(parsedValue1, parsedValue2);
            String formatConjunction = wu.getFormat(validatedInputs[0], conjunction, scanner);

            boolean disjunction = wu.disjunction(parsedValue1, parsedValue2);
            String formatDisjunction = wu.getFormat(validatedInputs[0], disjunction, scanner);

            System.out.println("You entered two valid truth values: " + validatedInputs[0] + " and " + validatedInputs[1]);
            System.out.println("The conjunction (AND) of those values is: " + formatConjunction);
            System.out.println("The disjunction (OR) of those values is: " + formatDisjunction);
        }

        scanner.close();
    }
     
}
