package COMP5511.assignment1;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.math.BigInteger; 

// code fragment 5.10, from textbook, pg. 211
// code fragment 5.13, from textbook, pg. 216
public class BinaryFib {   
     // use BigInteger for accuracy of output on large fibonacci executions
    public static BigInteger binaryFibonacci(BigInteger n) {
        // base case
        if (n.equals(BigInteger.ZERO) || n.equals(BigInteger.ONE)) {
            return n;
        } else {
            // if not base case, two recursive calls of two preceding values
            return binaryFibonacci(n.subtract(BigInteger.ONE)).add(binaryFibonacci(n.subtract(BigInteger.TWO)));
        }
    }
    
    public static void main(String[] args) {
        // start execution time of main
        long startMainTime = System.nanoTime();
        // set PrintStream outside of try block to access is for execution time of overall `main` function
        PrintStream out = null;
        try {
            // use PrintStream to output executions (calculation results and timings) to a file
            out = new PrintStream("COMP5511/assignment1/BinaryFib_out.txt");
            // every System output sent to file
            System.setOut(out);

            // set of testing values for binary fibonacci calculations
            // removed 60, 55 and 50, since it took over 10 minutes!
            int[] numbers = {5, 10, 15, 20, 25, 30, 35, 40, 45};

            for (long number : numbers) {
                // each call will have a separate execution time calculation
                long startTime = System.nanoTime();
                BigInteger binaryResult = binaryFibonacci(BigInteger.valueOf(number));
                long endTime = System.nanoTime();

                // execution time (nanoseconds) convert to seconds
                double duration = (endTime - startTime) / 1_000_000_000.0;

                out.println("\n binary Fibonnacci of: " + number + " = " + binaryResult);
                out.println(String.format("\t execution time =  %.9f", duration ) + " seconds");
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        //output main function execution time at end of same file
        long endMainTime = System.nanoTime();
        double mainDuration = (endMainTime - startMainTime) / 1_000_000_000.0;
        out.println("\n\n TOTAL execution time = " + mainDuration);
    }
}
