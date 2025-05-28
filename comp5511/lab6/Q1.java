package COMP5511.lab6;

import java.util.PriorityQueue;

public class Q1 {

    private static PriorityQueue<Integer> getLargestElements(int[] arr, int num) {
        PriorityQueue<Integer> result = new PriorityQueue<>();
        for (int i = 0; i < arr.length; i++) {
            result.add(arr[i]);
            if (result.size() > num) {
                result.poll();
            }
        }
        return result;
    }

    public static void main(String[] args) {
        int[] arr = {7, 10, 4, 3, 20, 15};
        int k = 3;
        PriorityQueue<Integer> largesElements = getLargestElements(arr, k);
        System.out.println("The " + k + " largest elements are: ");
        System.out.println(largesElements.toString());
    }
}
