public class problem2 {
    // Method to calculate the sum of natural numbers recursively
    public static int sum(int n) {
        // Base case
        if (n == 0) {
            return 0;
        }
        // Recursive case
        return n + sum(n - 1);
    }

    public static void main(String[] args) {
        int number = 10; // Example input
        System.out.println("Sum of numbers from 1 to " + number + " is: " + sum(number));
    }
}
