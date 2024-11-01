package COMP5361.programmingAssignment2;

import java.util.Scanner;
import java.io.FileNotFoundException;
import java.io.File;
import java.io.PrintStream;
import java.util.ArrayList;

public class GrammarRegex {
    

    private static ArrayList<String> readSentencesFromFile(String fileName) {
        ArrayList<String> sentences = new ArrayList<>();
        
        try (Scanner scanner = new Scanner(new File(fileName))) {
            while (scanner.hasNextLine()) {
                sentences.add(scanner.nextLine());
            }
        } catch (FileNotFoundException e) {
            System.err.println("File not found: " + fileName);
        }
        return sentences;
    }  

    public static void main(String[] args) {
    
        String inputFile = "COMP5361/programmingAssignment2/IO/datePhoneIN.txt";
        String outputFile = "COMP5361/programmingAssignment2/IO/datePhoneOUT.txt";

        ArrayList<String> sentences = readSentencesFromFile(inputFile);

        try (PrintStream out = new PrintStream(new File(outputFile))) {
            for (String sentence : sentences) {
               out.println(sentence);
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error opening output file: " + outputFile);
        }
    }
}
