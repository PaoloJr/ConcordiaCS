package COMP5511.assignment1;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.math.BigInteger;

// code fragment 5.14 from textbook, pg. 217
public class LinearFib {

    public static BigInteger[] linearFibonacci(int n) {
        if(n <= 1) {
            BigInteger[] result = {BigInteger.valueOf(n), BigInteger.ZERO};
            return result;
        } else {
            // single recursive call
            BigInteger[] temp = linearFibonacci(n - 1);
            // return an array, 0th index = sum of values
            BigInteger[] result = {temp[0].add(temp[1]), temp[0], temp[1]};
            return result;
        }
    }

    public static void main(String[] args) {
        // start execution time of main
        long startMainTime = System.nanoTime();

        // set PrintStream outside of try block to access is for execution time of overall `main` function
        PrintStream out = null;
        try {
            // use PrintStream to output executions (calculation results and timings) to a file
            out = new PrintStream("COMP5511/assignment1/LinearFib_out.txt");
            // every System output sent to file
            System.setOut(out);

            int[] numbers = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50};

            for (int number : numbers) {
                // each call will have a separate execution time calculation
                long startTime = System.nanoTime();
                BigInteger[] linearResult = linearFibonacci(number);
                long endTime = System.nanoTime();

                // execution time (nanoseconds) convert to seconds
                double duration = (endTime - startTime) / 1_000_000_000.0;
                
                out.println("\n linear Fibonacci of: " + number + " = " + linearResult[0]);
                out.println("\t sum of these two numbers: " + linearResult[1] + " + " + linearResult[2]);
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
