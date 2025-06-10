package COMP5511.writtenAssignment2;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Q2b {

    public static ArrayList<List<Integer>> permutationsNonRecurse(int[] integers) {
        // Initialize the result list
        ArrayList<List<Integer>> result = new ArrayList<>(); // O(1)

        // Use LinkedList as a queue to hold partial permutations (as lists)
        Queue<List<Integer>> queue = new LinkedList<>(); // O(1)

        // enqueuing an empty list to represent the initial empty permutation
        // Enqueue an empty list to start building permutations
        queue.offer(new ArrayList<>());  // O(1)

        // Process each element in the integers array
        for (int i = 0; i < integers.length; i++) { // O(n)
            int currInt = integers[i]; // O(1)

            int currentQueueSize = queue.size(); // O(1)

            // For each existing permutation, create new permutations with the current element
            for (int j = 0; j < currentQueueSize; j++) { // O(n!)
                // Dequeue a permutation (a list of integers)
                List<Integer> currentPerm = queue.poll(); // O(1)

                // Insert the current element at all possible positions in the permutation
                for (int k = 0; k <= currentPerm.size(); k++) { // O(n)
                    // Create a new list for the new permutation
                    List<Integer> newPerm = new ArrayList<>(currentPerm); // O(n)

                    // Insert the current element at the k-th position
                    newPerm.add(k, currInt); // O(n), due to shifting elements

                    // Enqueue the new permutation
                    queue.offer(newPerm); // O(1)
                }
            }
        }

        // Transfer all permutations from the queue to the result list
        while (!queue.isEmpty()) { // O(n!)
            // Dequeue the final permutations and add them to the result
            result.add(queue.poll()); // O(1)
        }

        return result; // O(1)
    }

    public static void main(String[] args) {
        int[] intArray = {1, 2, 3};
        ArrayList<List<Integer>> retArrayList = permutationsNonRecurse(intArray);
        System.out.println(retArrayList);
        System.out.println("Total input size: " + intArray.length + "\nTotal permutations: " + retArrayList.size());
    }
}
