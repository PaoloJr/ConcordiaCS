package COMP5511.programmingAssignment2;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.io.FileNotFoundException;
import java.io.File;
import java.io.PrintStream;
import COMP5511.programmingAssignment2.Stack;

public class Arithmetic {
    private static Map<String, Integer> opsAndPreceMap;
    
    public Arithmetic() {
        opsAndPreceMap = new HashMap<String, Integer>();
        opsAndPreceMap.put("(", 1);
        opsAndPreceMap.put(")", 1);
        opsAndPreceMap.put("^", 2);
        opsAndPreceMap.put("*", 3);
        opsAndPreceMap.put("/", 3);
        opsAndPreceMap.put("+", 4);
        opsAndPreceMap.put("-", 4);
        opsAndPreceMap.put(">", 5);
        opsAndPreceMap.put(">=", 5);
        opsAndPreceMap.put("<", 5);
        opsAndPreceMap.put("<=", 5);
        opsAndPreceMap.put("==", 6);
        opsAndPreceMap.put("!=", 6);
    }
    
    private static int precedence(String op) {
        return opsAndPreceMap.getOrDefault(op, -1);
    }
    
    private static boolean isOperator(String op) {
        return opsAndPreceMap.containsKey(op);    
    }


    // private static Stack readExpressionsFromFile(String fileName) {
    //     Stack<String> expressions = new Stack(0);
        
        
    //     return expressions;
    // }

    public static int evaluateExpressions(String expression) {
        Stack<Integer> operandStack = new Stack<>(0);
        Stack<String> operatorStack = new Stack<>(0);

        for (int i = 0; i < expression.length(); i++) {
            char token = expression.charAt(i);
            String tokenStr = Character.toString(token);

            // If the token is a whitespace, skip it
            if (Character.isWhitespace(token)) {
                continue;
            }

            // If the token is a digit, push it onto the operand stack
            if (Character.isDigit(token)) {
                int num = 0;
                while (i < expression.length() && Character.isDigit(expression.charAt(i))) {
                    num = num * 10 + (expression.charAt(i) - '0');
                    i++;
                }
                i--; // Adjust for the outer loop increment
                operandStack.push(num);
            } 
            // If the token is an opening parenthesis, push it onto the operator stack
            else if (token == '(') {
                operatorStack.push(tokenStr);
            } 
            // If the token is a closing parenthesis, solve the subexpression
            else if (token == ')') {
                while (!operatorStack.isEmpty() && operatorStack.peek() != "(") {
                    operandStack.push(applyOperation(operatorStack.pop(), operandStack.pop(), operandStack.pop()));
                }
                operatorStack.pop(); // Pop the '('
            } 
            // If the token is an operator
            else if (isOperator(tokenStr)) {
                while (!operatorStack.isEmpty() && precedence(operatorStack.peek()) >= precedence(tokenStr)) {
                    operandStack.push(applyOperation(operatorStack.pop(), operandStack.pop(), operandStack.pop()));
                }
                operatorStack.push(tokenStr);
            }
        }

        // Entire expression has been parsed, apply remaining operations
        while (!operatorStack.isEmpty()) {
            operandStack.push(applyOperation(operatorStack.pop(), operandStack.pop(), operandStack.pop()));
        }

        // Result is the last operand in the stack
        return operandStack.pop();
    }


    private static int applyOperation(String op, int b, int a) {
        switch (op) {
            case "+":
                return a + b;
            case "-":
                return a - b;
            case "*":
                return a * b;
            case "/":
                if (b == 0) {
                    throw new UnsupportedOperationException("Cannot divide by zero");
                }
                return a / b;
            case "^":
                return (int) Math.pow(a, b);
        }
        return 0;
    }

    public static void main(String[] args) {
        String inputFileName = "arithmeticIn.txt";
        String outputFileName = "arithmeticOut.txt";

        try {
            // read from a file
            Scanner in = new Scanner(new File(inputFileName));
            // output results to a file
            PrintStream out = new PrintStream(outputFileName);
            // every System output sent to file
            System.setOut(out);

            while (in.hasNextLine()) {
                String data = in.nextLine();
                System.out.println("Line: " + data);
            }

            in.close();
        } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        
    }
}
