package COMP5361.assignment1;

import java.util.Scanner;

// code version 2
public class warmUp {


    private static Boolean negation(String value) {
        return !Boolean.valueOf(value);
    }

    private static String[] getValidBooleans(Scanner scanner) {
        while (true) {
            System.out.print("Enter one or two (space-separated) truth values (True, False, T, F, 0, 1): ");
            String line = scanner.nextLine().trim();
            String[] inputs = line.split("\\s+");
            
            if (inputs.length == 1 || inputs.length == 2) {
                try {
                    String value1 = parseBoolean(inputs[0]);
                    if (inputs.length == 2) {
                        String value2 = parseBoolean(inputs[1]);
                        return new String[]{value1, value2};
                    } else {
                        return new String[]{value1};
                    }
                } catch (IllegalArgumentException e) {
                    System.out.println(e.getMessage());
                }
            } else {
                System.out.println("Invalid input. Please enter one or two (space-separated) truth values.");
            }
        }
    }

   private static String parseBoolean(String input) {
        if (input.equalsIgnoreCase("true") || input.equalsIgnoreCase("t") || input.equals("1")) {
            return input;
        } else if (input.equalsIgnoreCase("false") || input.equalsIgnoreCase("f") || input.equals("0")) {
            return input;
        } else {
            throw new IllegalArgumentException("Invalid input: " + input + "\nMust be 'True', 'False', 'T', 'F', '0', or '1'.");
        }
    }
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String[] values = getValidBooleans(scanner);
        
        if (values.length == 1) {
            System.out.println("You entered one valid value: " + values[0]);
            Boolean negatedValue = negation(values[0]);
            System.out.println("The negated value is: " + negatedValue);

        } else if (values.length == 2) {
            System.out.println("You entered two valid values: " + values[0] + " and " + values[1]);
        }
        
        scanner.close();
    }
}




// code version 1

// public static boolean negation(Object value) {
//     if (value instanceof Boolean) {
//         return !(Boolean) value;
//     } else if (value instanceof String) {
//         String strValue = (String) value;
//         if ("true".equalsIgnoreCase(strValue) || "t".equalsIgnoreCase(strValue)) {
//             return false;
//         } else if ("false".equalsIgnoreCase(strValue) || "f".equalsIgnoreCase(strValue)) {
//             return true;
//         } else {
//             throw new IllegalArgumentException("Invalid input. Please enter a boolean value. Either '0' and/or '1', 'True' and/or 'False', 'T' and/or 'F'");                
//         }
//     } else {
//         throw new IllegalArgumentException("Invalid input. Please enter a boolean value. Either '0' and/or '1', 'True' and/or 'False', 'T' and/or 'F'");                
//     }
// }

// public static void main(String[] args) {
    //     Scanner scanner = new Scanner(System.in);
    //     boolean value = getValidValue(scanner);
    //     System.out.print("Enter a truth value: ");
    //     boolean bool = scanner.nextBoolean();
    //     String str = scanner.next("T""F");
    //     scanner.close();
    
    //     boolean userInput = negation(bool);
    //     System.out.println("Value entered: " + bool + "\nValue returned: " + userInput);
        // boolean first = true;
    // boolean second = false;
    // int num = 1;
    // boolean testFirst = negation(first);
    // boolean testSecond = negation(second);
    // System.out.println("Value entered: " + first + "\nValue returned: " + testFirst);
    // System.out.println("Value entered: " + second + "\nValue returned: " + testSecond);
    
    // boolean error = negation(num);
        // System.out.println(error);
    // }
    
    // }

    // public static boolean getValidValue(Scanner scanner) {
    //     while (true) {
    //         System.out.print("Enter a value (True, False, T, F, 0, 1): ");
    //         String input = scanner.next().trim();
    
    //         // Check the valid cases ignoring case sensitivity
    //         if (input.equalsIgnoreCase("true") || input.equalsIgnoreCase("t") || input.equals("1")) {
    //             return true;
    //         } else if (input.equalsIgnoreCase("false") || input.equalsIgnoreCase("f") || input.equals("0")) {
    //             return false;
    //         } else {
    //             System.out.println("Invalid input. Please enter 'True', 'False', 'T', 'F', '0', or '1'.");
    //         }
    //     }
    // }