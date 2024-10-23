package COMP5511.programmingAssignment2;

import java.util.Scanner;
import java.io.FileNotFoundException;
import java.io.File;
import java.io.PrintStream;
import COMP5511.programmingAssignment2.Stack;

public class Arithmetic {

    private static Stack readExpressionsFromFile(String fileName) {
        Stack expressions = new Stack();


        return expressions;
    }

    public static void main(String[] args) {
        String inputFileName = "arithmeticIn.txt";
        String outputFileName = "arithmeticOut.txt";

        try {
            // read from a file
            Scanner in = new Scanner(new File(inputFileName));
            // output results to a file
            PrintStream out = new PrintStream(outputFileName);
            // every System output sent to file
            System.setOut(out);

            while (in.hasNextLine()) {
                String data = in.nextLine();
                System.out.println("Line: " + data);
            }

            in.close();
        } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        
    }
}
