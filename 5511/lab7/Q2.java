package COMP5511.lab7;

import java.util.HashMap;
import java.util.Arrays;

public class Q2 {
    
    private static int[] twoSum(int[] nums, int target){
        HashMap<Integer, Integer> map = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            int currNum = nums[i];
            int complement = target - currNum;

            // check if complement is in map
            if (map.containsKey(complement)) {
                return new int[] {map.get(complement), i};
            }
            // store the index of the current number
            map.put(currNum, i);
        }
        return new int[] {};
    }

    public static void main(String[] args) {
        int[] nums = {2, 7, 11, 15, 15};
        int target = 9;
        int[] result = twoSum(nums, target);
        
        System.out.println("Indices of the two numbers: " + Arrays.toString(result));
    }
}
