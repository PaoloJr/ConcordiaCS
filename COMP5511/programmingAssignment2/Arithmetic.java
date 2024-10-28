package COMP5511.programmingAssignment2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.io.FileNotFoundException;
import java.io.File;
import java.io.PrintStream;

public class Arithmetic {
    private static Map<String, Integer> opsAndPreceMap;
    
    static {
        opsAndPreceMap = new HashMap<String, Integer>();
        // opsAndPreceMap.put("(", 1);
        // opsAndPreceMap.put(")", 1);
        opsAndPreceMap.put("^", 6);
        opsAndPreceMap.put("*", 5);
        opsAndPreceMap.put("/", 5);
        opsAndPreceMap.put("+", 4);
        opsAndPreceMap.put("-", 4);
        opsAndPreceMap.put(">", 3);
        opsAndPreceMap.put(">=", 3);
        opsAndPreceMap.put("<", 3);
        opsAndPreceMap.put("<=", 3);
        opsAndPreceMap.put("==", 2);
        opsAndPreceMap.put("!=", 2);
    }
    public static void main(String[] args) {
        String inputFileName = "COMP5511/programmingAssignment2/arithmeticIn.txt";
        // String inputFileName = "COMP5511/programmingAssignment2/testIn.txt";
        String outputFileName = "COMP5511/programmingAssignment2/arithmeticOut.txt";

        ArrayList<String> expressions = readExpressionsFromFile(inputFileName); // O(n)

        // for (String item : expressions) {
        //     System.out.println(item);
        // }

        try (PrintStream out = new PrintStream(new File(outputFileName))) {
            for (String expression : expressions) {
                evaluateExpressions(expression, out);
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error opening output file: " + outputFileName);
        }
    }

    private static ArrayList<String> readExpressionsFromFile(String fileName) {
        ArrayList<String> expressions = new ArrayList<>(); // O(1)
        
        try (Scanner scanner = new Scanner(new File(fileName))) {
            while (scanner.hasNextLine()) { // O(n)
                expressions.add(scanner.nextLine()); // O(1)
            }
        } catch (FileNotFoundException e) {
            System.err.println("File not found: " + fileName);
        }
        return expressions;
    }    
    
    public static void evaluateExpressions(String expression, PrintStream out) {
        try {
            // Tokenize the expression (ArrayList)
            ArrayList<String> tokens = tokenizeExpression(expression); // O(n)

            // Evaluate the expression using two stacks (operands and operators)
            int result = evaluateTokens(tokens); // O(n)

            // Output the result to file
            out.println("Expression: " + expression);
            out.println("Result: " + (isBooleanExpression(tokens) ? (result == 1 ? "true" : "false") : result));
            out.println();
        } catch (Exception e) {
            out.println("Expression: " + expression);
            out.println("Error: " + e.getMessage());
            out.println();
        }
    }

    private static ArrayList<String> tokenizeExpression(String expression) {
        ArrayList<String> tokens = new ArrayList<>();
        int i = 0;
        while (i < expression.length()) { // O(n), size of expression element in ArrayList
            char currentChar = expression.charAt(i); // O(1)

            // Skip whitespace
            if (Character.isWhitespace(currentChar)) {
                i++;
                continue;
            }

             // Handle numbers (including negative numbers)
            if (Character.isDigit(currentChar) || currentChar == '-') {
                // Check if '-' is a unary minus
                boolean isNegative = false;
                if (currentChar == '-') {
                    // Unary minus if at the start or after an operator or '('
                    if (i == 0 || tokens.isEmpty() || tokens.get(tokens.size() - 1).equals("(") || isOperator(tokens.get(tokens.size() - 1))) {
                        isNegative = true;
                        i++;
                    } else {
                        // It's a unary minus operator
                        tokens.add("-");
                        i++;
                        continue;
                    }
            }

            // build sequence of numbers
            StringBuilder number = new StringBuilder();
            if (isNegative) {
                number.append('-');
            }
            while (i < expression.length() && Character.isDigit(expression.charAt(i))) {
                number.append(expression.charAt(i));
                i++;
            }
            tokens.add(number.toString());
            continue;
        }

            // Handle multi-character operators (ex: `<=`, `>=`, `!=`, `==`)
            if (i + 1 < expression.length()) {
                String twoCharOp = expression.substring(i, i + 2);
                if (isOperator(twoCharOp)) {
                    tokens.add(twoCharOp);
                    i += 2;
                    continue;
                }
            }

            // Handle single-character operators and parentheses
            String singleCharOp = Character.toString(currentChar);
            if (isOperator(singleCharOp) || singleCharOp.equals("(") || singleCharOp.equals(")")) {
                tokens.add(singleCharOp);
                i++;
                continue;
            }

            throw new IllegalArgumentException("Invalid character in expression: " + currentChar);
        }
        return tokens;
    }

    private static int evaluateTokens(ArrayList<String> tokens) {
        // ArrayListStack<Integer> operandStack = new ArrayListStack<>();
        // ArrayListStack<String> operatorStack = new ArrayListStack<>();
        ArrayStack<Integer> operandStack = new ArrayStack<>();
        ArrayStack<String> operatorStack = new ArrayStack<>();

        int i = 0;
        while (i < tokens.size()) { // O(n), size of ArrayList
            // current token
            String token = tokens.get(i);

            // If token is a number (or multiple sequence of numbers), push it to operand stack
            if (token.matches("-?\\d+")) {
                operandStack.push(Integer.parseInt(token));
                i++;
            }
            // If token is '(', push it to operator stack
            else if (token.equals("(")) {
                operatorStack.push(token);
                i++;
            }
            // If token is ')', solve the entire parenthesis
            else if (token.equals(")")) {
                while (!operatorStack.isEmpty() && !operatorStack.peek().equals("(")) {
                    performOperation(operandStack, operatorStack);
                }
                if (operatorStack.isEmpty()) {
                    throw new IllegalArgumentException("Mismatched parentheses");
                }
                 // Remove '('
                operatorStack.pop();
                i++;
            }
            // If token is an operator
            else if (isOperator(token)) {
                // check if current token (from ArrayList input) has higher / lower precedence than the operator stack's top
                while (!operatorStack.isEmpty() && hasHigherPrecedence(operatorStack.peek(), token)) {
                    performOperation(operandStack, operatorStack);
                }
                operatorStack.push(token);
                i++;
            } else {
                throw new IllegalArgumentException("Unknown token: " + token);
            }
        }

        // Apply remaining operators
        while (!operatorStack.isEmpty()) {
            if (operatorStack.peek().equals("(") || operatorStack.peek().equals(")")) {
                throw new IllegalArgumentException("Mismatched parentheses");
            }
            performOperation(operandStack, operatorStack);
        }

        if (operandStack.size() != 1) {
            throw new IllegalArgumentException("Invalid expression");
        }

        return operandStack.pop();
    }

    private static boolean isBooleanExpression(ArrayList<String> tokens) {
        if (tokens.contains(">") || tokens.contains("<") || tokens.contains(">=") ||tokens.contains("<=") ||
        tokens.contains("==") || tokens.contains("!=")) {
            return true;
        }
        return false;
    }

    private static int precedence(String op) {
        return opsAndPreceMap.getOrDefault(op, -1);
    }
    
    private static boolean isOperator(String op) {
        return opsAndPreceMap.containsKey(op);    
    }

    private static boolean hasHigherPrecedence(String op1, String op2) {
        int p1 = precedence(op1);
        int p2 = precedence(op2);
        return p1 >= p2;
    }

    private static void performOperation(ArrayStack<Integer> operandStack, ArrayStack<String> operatorStack) {
        if (operandStack.size() < 2) {
            throw new IllegalArgumentException("Insufficient operands");
        }

        // pop first operand
        int b = operandStack.pop(); // O(1)
        // pop second operand
        int a = operandStack.pop(); // O(1)
        // pop associated operator
        String op = operatorStack.pop(); // O(1)

        // use popped operands and operator and run calculation
        // b is first operand, a is second operand
        int result = applyOperation(op, b, a); // O(1)
        // add resulting integer to the operandStack
        operandStack.push(result); // O(1)
    }

    private static int applyOperation(String op, int b, int a) {
        switch (op) {
            case "+": return a + b;
            case "-": return a - b;
            case "*": return a * b;
            case "/":
                if (b == 0) throw new UnsupportedOperationException("Cannot divide by zero");
                return a / b;
            case "^": return (int) Math.pow(a, b);
            case ">": return a > b ? 1 : 0;
            case "<": return a < b ? 1 : 0;
            case ">=": return a >= b ? 1 : 0;
            case "<=": return a <= b ? 1 : 0;
            case "==": return a == b ? 1 : 0;
            case "!=": return a != b ? 1 : 0;
            default: throw new IllegalArgumentException("Invalid operator: " + op);
        }
    }  
}