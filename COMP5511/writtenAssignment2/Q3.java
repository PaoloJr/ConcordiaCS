package COMP5511.writtenAssignment2;

import java.util.LinkedList;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;

// generate all possible subsets of a given set T (power set of T) containing n elements
// non-recursive and use a stack and/or queue
public class Q3 {

    // Function to generate power set
    static void generatePowerSet(char[] set) {
        Queue<List<Character>> queue = new LinkedList<>(); // O(1)
        // Start with the empty set
        // each set will be placed in an ArrayList
        queue.add(new ArrayList<>()); // O(1)
        
        // Iterate through all elements in the set
        for (char element : set) { // O(n)
            int currentSize = queue.size(); // O(1) 
            
            // For each subset already in the queue, create a new subset with the current element
            for (int i = 0; i < currentSize; i++) { // O(2^n)
                // Get the current subset, first element
                List<Character> subset = queue.poll(); // O(1)

                // System.out.println("subset: " + subset);
                
                // Add the current subset back to the queue (excluding the element)
                queue.add(new ArrayList<>(subset)); // O(n)
                
                // Create a new subset that includes the current element and add it to the queue
                subset.add(element); // O(1)
                queue.add(new ArrayList<>(subset)); // O(n)

                // System.out.println("queue" + queue);
            }
        }
        
        // Print all subsets in the queue
        int totalSubsets = 0;
        while (!queue.isEmpty()) { // O(2^n)
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
