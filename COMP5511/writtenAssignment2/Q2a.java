package COMP5511.writtenAssignment2;

import java.util.ArrayList;
import java.util.List;

public class Q2a {
    
    public static ArrayList<List<Integer>> permutationsRecurse(int[] integers, int length) {
        // Initialize result lists
        ArrayList<List<Integer>> result = new ArrayList<>(); // O(1)

        // Base case: if there is only one element, return it as the only permutation
        if (length == 1) { // O(1)
            List<Integer> singlePerm = new ArrayList<>();
            singlePerm.add(integers[0]); // O(1)
            result.add(singlePerm); // O(1)
            return result; // O(1)
        }

        // Recursive case: generate permutations for the array excluding the last element
        // it will start with the base case of [1], then add 2 in every position `i`, then 3 in every position `i`
        ArrayList<List<Integer>> smallerPermutations = permutationsRecurse(integers, length - 1); // O(n - 1)!

        // Get the last element to insert into permutations of the smaller array
        int lastElement = integers[length - 1]; // O(1)

        // For each permutation in smallerPermutations, insert the last element into all positions
        for (List<Integer> perms : smallerPermutations) { // O((n - 1)!)
            for (int i = 0; i <= perms.size(); i++) { // O(n)
                // Create a new list for each new permutation
                List<Integer> newPerm = new ArrayList<>(perms); // O(n)

                // Insert the last element at the i-th position
                newPerm.add(i, lastElement); // O(1)

                // Add the new permutation to the result
                result.add(newPerm); // O(1)
            }
        }

        return result; // O(1)
    }


    public static void main(String[] args) {
        int[] testIntegers = {1, 2, 3};
        ArrayList<List<Integer>> permutations = permutationsRecurse(testIntegers, testIntegers.length);
        for (List<Integer> perm : permutations) {
            System.out.println(perm);
        }
        System.out.println("Total permutations = " + permutations.size());
    }
}
