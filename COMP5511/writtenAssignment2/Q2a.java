package COMP5511.writtenAssignment2;

import java.util.ArrayList;
import java.util.Arrays;

public class Q2a {
    
    public static ArrayList<Integer[]> permutationsRecurse(int n) {
        // permutation is an array of integers
        ArrayList<Integer[]> resultWith1 = new ArrayList<>();
        ArrayList<Integer[]> result = new ArrayList<>();
        
        if (n == 1) {
            resultWith1.add(new Integer[]{1});
            return resultWith1;
        } else {
            // list holding all other permutations (from smaller n)
            ArrayList<Integer[]> smallerPermutations  = permutationsRecurse(n - 1);
            // for each permutation in smallerPermutations
            for (Integer[] perms : smallerPermutations) {
                // insert n into every possible position of the current permutation
                for (int i = 0; i <= perms.length; i++) {
                    Integer[] newPerm = new Integer[perms.length + 1];
                    // copy elements before insertion
                    for (int j = 0; j < i; j++) {
                        newPerm[j] = perms[j];                        
                    }
                    // insert n at position i
                    newPerm[i] = n;

                    // copy other elements in permutation
                    for (int k = i + 1; k <= perms.length; k++) {
                        newPerm[k] = perms[k -1];
                    }
                    result.add(newPerm);
                }
            }
        }
        return result;
    }   
    public static void main(String[] args) {
        int testInt = 4;
        ArrayList<Integer[]> permutations = permutationsRecurse(testInt);
        for (Integer[] perm : permutations) {
            System.out.println(Arrays.toString(perm));
        }
        System.out.println("Permutations size = " + permutations.size());
    }
}
