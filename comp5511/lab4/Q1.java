package COMP5511.lab4;

import java.util.Stack;

public class Q1 {

    private static boolean stringChecker(String sampleString) {
        Stack<Character> stack = new Stack<>();
       boolean result = false;

        for (int i = 0; i < sampleString.length(); i++) {
            char character = sampleString.charAt(i);
            if(character == '{' || character =='[' || character == '(') {
                stack.push(character);
            }
        }
        return result;
    }

    // private static boolean isMatchingPair(char open, char close) {
    //     boolean result = false;

    //     return result;
    // }

    public static void main(String[] args) {
        String first = "{[()]}"; // balanced
        String second = "{[(])}"; // not balanced
        String third = "{{[[(())]]}}"; // balanced

        boolean returnFirst = stringChecker(first);
        System.out.println("Is this: " + first + " balanced? --> " + returnFirst);
        
        boolean returnSecond = stringChecker(second);
        System.out.println("Is this: " + second + " balanced? --> " + returnSecond);

        boolean returnThird = stringChecker(third);
        System.out.println("Is this: " + third + " balanced? --> " + returnThird);
    }
}

