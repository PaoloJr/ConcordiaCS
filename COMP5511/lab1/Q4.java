package COMP5511.lab1;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Q4 {
    public static void main(String[] args) {
        try {
            File file = new File("rad.txt");
            Scanner scanner = new Scanner(file);
            int wordCount = 0;

            while (scanner.hasNext()) {
                scanner.next();
                wordCount++;
            }

            System.out.println("Number of words: " + wordCount);
            scanner.close();
        } catch (FileNotFoundException e) {
            System.out.println("File not found.");
        }
    }
}
