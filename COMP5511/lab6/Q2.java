package COMP5511.lab6;

import java.util.ArrayList;

public class Q2 {

    // merge sorted arrays
    private static ArrayList<Integer> mergeArrays(int[] arr1, int[] arr2) {
        ArrayList<Integer> result = new ArrayList<Integer>();

        int i = 0;
        int j = 0;

        while(i < arr1.length && j < arr2.length) {
            if (arr1[i] <= arr2[j]) {
                result.add(arr1[i]);
                i++;
            } else {
                result.add(arr2[j]);
                j++;
            }
        }

          // Add remaining elements of arr1
          while (i < arr1.length) {
            result.add(arr1[i]);
            i++;
        }

        // Add remaining elements of arr2
        while (j < arr2.length) {
            result.add(arr2[j]);
            j++;
        }
        return result;
    }
    public static void main(String[] args) {
        int[] arr1 = {1, 3, 5, 7, 9};
        int[] arr2 = {2, 4, 6, 8, 10};
        ArrayList<Integer> result = mergeArrays(arr1, arr2);
        System.out.println("Single sorted array: " + result);
    }
}