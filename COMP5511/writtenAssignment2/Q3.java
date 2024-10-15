package COMP5511.writtenAssignment2;

import java.util.Stack;

// generate all possible subsets of a given set T (power set of T) containing n elements
// non-recursive and use a stack and/or queue
public class Q3 {

    static void generatePowerSet(char[] set) {
        int setSize = set.length;
        int totalSubsets = 0;
        Stack<Character> stack = new Stack<>();

        // Iterate over all possible subsets
        for (int i = 0; i < Math.pow(2, setSize); i++) {
            stack.clear();
            // print left brace
            System.out.print("{ ");

                // Determine which elements are in the current subset
                for (int j = 0; j < setSize; j++) {
                    // Check if the j-th bit of i is 1 (indicating the j-th element should be included in the subset)
                    // We do this by shifting i right by j positions and checking the least significant bit
                    // If the result is 1, the element is included and pushed to the stack
                    // If the result is 0, the element is excluded
                    if ((i / (int) Math.pow(2, j) % 2 == 1)) {
                        stack.push(set[j]);
                    }
                }

                // print the current subset
                for (Character ch : stack) {
                    System.out.print(ch + " ");
                }
            // print right brace
            System.out.println("}");
            totalSubsets++;
        }
        System.out.println("Power Set Cardinality: " + totalSubsets);
    }
    public static void main(String[] args) {
        char set[] = {'a', 'b'};
        generatePowerSet(set);
    }
}