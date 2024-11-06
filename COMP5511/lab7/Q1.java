package COMP5511.lab7;

import java.util.HashMap;

public class Q1 {

    private static int firstRepeatChar(String string) {
        HashMap<Character, Integer> map = new HashMap<>();
        for (int i = 0; i < string.length(); i++) {
            char currChar = string.charAt(i);
            if (map.containsKey(currChar)) {
                map.put(currChar, map.get(currChar) + 1);
            } else {
                map.put(currChar, 1);                
            }
        }
        System.out.println("Map for String: " + string + " \n" + map);
        
        for (int i = 0; i < string.length(); i++) {
            int mapResult = map.get(string.charAt(i));
            // System.out.println(mapResult);
            if (mapResult > 1) {
                return i;
            }
        }
        return -1;
    }
    
    public static void main(String[] args) {
        String s1 = "leetcode";
        String s2 = "aabbcc";

        int result1 = firstRepeatChar(s1);
        int result2 = firstRepeatChar(s2);

        System.out.println("Result 1: " + result1);
        System.out.println("Result 2: " + result2);
    }    
}
