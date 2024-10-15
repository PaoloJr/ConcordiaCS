package COMP5511.lab2;

public class problem1 {
    // Method to calculate factorial recursively
    public static int factorial(int n) {
        // Base case
        if (n == 0) {
            return 1;
        }
        // Recursive case
        return n * factorial(n - 1);
    }

    public static void main(String[] args) {
        int number = 5; // Example input
        System.out.println("Factorial of " + number + " is: " + factorial(number));
    }
}
