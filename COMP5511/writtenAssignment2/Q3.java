package COMP5511.writtenAssignment2;

import java.util.Stack;
import java.util.ArrayList;

// // generate all possible subsets of a given set T (power set of T) containing n elements
// // non-recursive and use a stack and/or queue
// public class Q3 {

//     static void generatePowerSet(char[] set) {
//         int setSize = set.length;
//         int totalSubsets = 0;
//         Stack<Character> stack = new Stack<>();

//         // Iterate over all possible subsets
//         for (int i = 0; i < Math.pow(2, setSize); i++) {
//             stack.clear();
//             // print left brace
//             System.out.print("{ ");

//                 // Determine which elements are in the current subset
//                 for (int j = 0; j < setSize; j++) {
//                     // Check if the j-th bit of i is 1 (indicating the j-th element should be included in the subset)
//                     // We do this by shifting i right by j positions and checking the least significant bit
//                     // If the result is 1, the element is included and pushed to the stack
//                     // If the result is 0, the element is excluded
//                     if ((i / (int) Math.pow(2, j) % 2 == 1)) {
//                         stack.push(set[j]);
//                     }
//                 }

//                 // print the current subset
//                 for (Character ch : stack) {
//                     System.out.print(ch + " ");
//                 }
//             // print right brace
//             System.out.println("}");
//             totalSubsets++;
//         }
//         System.out.println("Power Set Cardinality: " + totalSubsets);
//     }
//     public static void main(String[] args) {
//         char set[] = {'a', 'b'};
//         generatePowerSet(set);
//     }
// }

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Q3 {

    // Function to generate power set
    static void generatePowerSet(char[] set) {
        Queue<List<Character>> queue = new LinkedList<>();
        queue.add(new ArrayList<>());  // Start with the empty set
        
        // Iterate through all elements in the set
        for (char element : set) {
            int currentSize = queue.size();
            
            // For each subset already in the queue, create a new subset with the current element
            for (int i = 0; i < currentSize; i++) {
                List<Character> subset = queue.poll();  // Get the current subset
                
                // Add the current subset back to the queue (excluding the element)
                queue.add(new ArrayList<>(subset));
                
                // Create a new subset that includes the current element and add it to the queue
                subset.add(element);
                queue.add(new ArrayList<>(subset));
            }
        }
        
        // Print all subsets in the queue
        int totalSubsets = 0;
        while (!queue.isEmpty()) {
            System.out.println(queue.poll());
            totalSubsets++;
        }
        System.out.println("Power Set Cardinality: " + totalSubsets);
    }

    public static void main(String[] args) {
        char[] set = {'a', 'b', 'c'};
        generatePowerSet(set);
    }
}
