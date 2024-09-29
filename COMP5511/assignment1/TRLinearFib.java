package COMP5511.assignment1;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.math.BigInteger;

public class TRLinearFib {

    private static BigInteger TRlinearFibonacci(int n, BigInteger a, BigInteger b) {
        // base case
        if(n <= 1) {
            return b;
        } else {
            // single tail-recursive call
            return  TRlinearFibonacci(n - 1, b, a.add(b));
            // parameter `a` takes the value of (argument) `b` in the subsequent calls
            // parameter `b` is the accumulated (sum) of `a` and `b`;  (n - 1) + (n - 2)
        }
    }

    public static void main(String[] args) {
        // start execution time of main
        long startMainTime = System.nanoTime();

        // set PrintStream outside of try block to access is for execution time of overall `main` function
        PrintStream out = null;
        try {
            // use PrintStream to output executions (calculation results and timings) to a file
            out = new PrintStream("COMP5511/assignment1/TRLinearFib_out.txt");
            // every System output sent to file
            System.setOut(out);

            int[] numbers = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100};

            for (int number : numbers) {
                // each call will have a separate execution time calculation
                long startTime = System.nanoTime();
                BigInteger linearResult = TRlinearFibonacci(number, BigInteger.ZERO, BigInteger.ONE);
                long endTime = System.nanoTime();

                // execution time (nanoseconds) convert to seconds
                double duration = (endTime - startTime) / 1_000_000_000.0;
                
                out.println("\n linear Fibonacci of: " + number + " = " + linearResult);
                // out.println("\t sum of these two numbers: " + linearResult[1] + " + " + linearResult[2]);
                out.println(String.format("\t execution time = %.9f",   duration) + " seconds");
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        long endMainTime = System.nanoTime();
        // execution time (nanoseconds) convert to seconds
        double mainDuration = (endMainTime - startMainTime) / 1_000_000_000.0;
        out.println("\n\n TOTAL execution time = " + mainDuration + " seconds");
    }
}
