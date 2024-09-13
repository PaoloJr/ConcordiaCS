package COMP5511.lab1;
import java.util.Scanner;

public class PrimeNumber {

    private int number;

    public PrimeNumber(int userNumber) {
        this.number = userNumber;
    }

    // public String isPrime(int number) {
        // String result = null;
        // if (number > 1) {
            // if (number /
        // } else {
            // return null;
        // }
        // return result;
    // }

    public static void main(String args[]) {
        int testNumber = 5;
        PrimeNumber pn = new PrimeNumber(testNumber);
        // System.out.println(pn.isPrime(testNumber));
    }

}