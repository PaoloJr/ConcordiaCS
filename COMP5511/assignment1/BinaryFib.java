package COMP5511.assignment1;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.math.BigInteger; 

// code fragment 5.10 from textbook
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
        long startMainTime = System.nanoTime();
        // set PrintStream outside of try block to access is for execution time of overall `main` function
        PrintStream out = null;
        try {
            // use PrintStream to output executions (calculation results and timings) to a file
            out = new PrintStream("COMP5511/assignment1/BinaryFib_out.txt");
            System.setOut(out);

            // set of testing values for binary fibonacci calculations
            // removed 55, since it took almost 10 minutes!
            int[] numbers = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50};

            for (long number : numbers) {
                // each call will have a separate execution time calculation
                long startTime = System.nanoTime();
                BigInteger binaryResult = binaryFibonacci(BigInteger.valueOf(number));
                long endTime = System.nanoTime();
                double duration = (endTime - startTime) / 1000000000.0;
                out.println("binary Fibonnacci of: " + number + " = " + binaryResult);
                out.println("execution time = " + duration + " seconds");
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        //output main function exec ution time to file
        long endMainTime = System.nanoTime();
        double mainDuration = (endMainTime - startMainTime) / 1000000000.0;
        out.println("TOTAL execution time = " + mainDuration);
    }
}
