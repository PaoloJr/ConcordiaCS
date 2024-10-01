package COMP5511.writtenAssignmentQ1;
/*
 * pseudo-code
 * 
 ** Algorithm MyAlgorithm (A,B)
 ** Input: Arrays A and B each storing n >= 1 integers.
 ** Output: What is the output? (Refer to part b below)
 ** Start:
 ** count = 0
 ** for i = 0 to n-1 do {
 **     sum = 0
 **     for j = 0 to n-1 do {
 **         sum = sum + A[0]
 **             for k = 1 to j do
 **             sum = sum + A[k]
 **             }
 **     if B[i] == sum then count = count + 1
 ** }
 ** return count
 *
 * What is the final output for input arrays A = [1, 2, 5, 9] and B = [2, 29, 40, 57]? Show the necessary steps.
 * 
 */


public class Q1 {

    public static int  MyAlgorithm(int[] A, int[] B) {
        int count = 0;
        for (int i = 0; i < A.length - 1; i++) {
            int sum = 0;
            for (int j = 0; j < A.length - 1; j++) {
                sum = sum + A[0];
                for (int k = 1; k <= j; k++) {
                    sum = sum + A[k];
                }
            }
            if (B[i] == sum) {
                count = count + 1;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        int[] A = {1, 2, 5, 9};
        int[] B = {2, 29, 40, 57};

        int returnValue = MyAlgorithm(A, B);
        System.out.println("Returned value = " + returnValue);
    }    
}
