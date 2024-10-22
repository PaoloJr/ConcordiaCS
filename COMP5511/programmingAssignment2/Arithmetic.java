package COMP5511.programmingAssignment2;

import java.util.Scanner;
import java.io.FileNotFoundException;
import java.io.File;
import java.io.PrintStream;
import COMP5511.programmingAssignment2.Stack;

public class Arithmetic {

    public static void main(String[] args) {
        try {
            // read from a file
            Scanner in = new Scanner(new File("COMP5511/programmingAssignment2/arithmeticIn.txt"));
            // output results to a file
            PrintStream out = new PrintStream("COMP5511/programmingAssignment2/arithmeticOut.txt");
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
