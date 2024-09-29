package COMP5511.assignment1;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.math.BigInteger;

// code fragment 5.14 from textbook
public class LinearFib {

    public static BigInteger[] linearFibonacci(int n) {
        if(n <= 1) {
            BigInteger[] result = {BigInteger.valueOf(n), BigInteger.ZERO};
            return result;
        } else {
            BigInteger[] temp = linearFibonacci(n - 1);
            BigInteger[] result = {temp[0].add(temp[1]), temp[0]};
            return result;
        }
    }

    public static void main(String[] args) {
        long startMainTime = System.nanoTime();

        // set PrintStream outside of try block to access is for execution time of overall `main` function
        PrintStream out = null;
        try {
            // use PrintStream to output executions (calculation results and timings) to a file
            out = new PrintStream("COMP5511/assignment1/LinearFib_out.txt");
            System.setOut(out);

            int[] numbers = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50};

            for (int number : numbers) {
                // each call will have a separate execution time calculation
                long startTime = System.nanoTime();
                BigInteger[] linearResult = linearFibonacci(number);
                long endTime = System.nanoTime();
                double duration = (endTime - startTime) / 1000000000.0;
                out.println("linear Fibonacci of: " + number + " = " + linearResult[0] + " " + linearResult[1]);
                out.println("execution time = " + duration + " seconds");
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        long endMainTime = System.nanoTime();
        double mainDuration = (endMainTime - startMainTime) / 1000000000.0;
        out.println("TOTAL execution time = " + mainDuration);
    }
}
