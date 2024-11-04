package COMP5361.programmingAssignment2;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.Scanner;
// import java.util.Arrays;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class GrammarRegex {

       private static final Map<String, Integer> months = new HashMap<>();

    static {
        months.put("January", 1); months.put("Jan", 1);
        months.put("February", 2); months.put("Feb", 2);
        months.put("March", 3); months.put("Mar", 3);
        months.put("April", 4); months.put("Apr", 4);
        months.put("May", 5);
        months.put("June", 6); months.put("Jun", 6);
        months.put("July", 7); months.put("Jul", 7);
        months.put("August", 8); months.put("Aug", 8);
        months.put("September", 9); months.put("Sep", 9); months.put("Sept", 9);
        months.put("October", 10); months.put("Oct", 10);
        months.put("November", 11); months.put("Nov", 11);
        months.put("December", 12); months.put("Dec", 12);
    }    

    public static void main(String[] args) {
    
        String inputFile = "COMP5361/programmingAssignment2/IO/datePhoneIN.txt";
        String outputFile = "COMP5361/programmingAssignment2/IO/datePhoneOUT.txt";

        ArrayList<String> sentences = readSentencesFromFile(inputFile);

        try (PrintStream out = new PrintStream(new File(outputFile))) {
            for (String sentence : sentences) {
            //    out.println(sentence);
            String phone = phoneNumberRegex(sentence);
            String date = dateRegex(sentence);
                out.println("Sentence: " + sentence);
                out.println("Detected phone number: " + phone);
                out.println("Detected date: " + date);
                out.println();
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error opening output file: " + outputFile);
        }
    }

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
    
    
    private static String phoneNumberRegex(String sentence) {
        String phoneRegex = "[(|+]?[1-9]?\\s?[(]?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}";
        Pattern pattern = Pattern.compile(phoneRegex);
        Matcher matcher = pattern.matcher(sentence);
        
        if (matcher.find()) {
            return matcher.group().trim();
            } else {
                return "Phone Match Not Found!";
            }
    }

    public static Integer getMonthNumber(String month) {
        return months.get(month);
    }
    
    private static String dateRegex(String sentence) {
        // Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun
        // January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec
        // Jan|Feb|Mar|Apr|May|Jun|June|Jul|July|Aug|Sep|Sept|Oct|Nov|Dec
        
        // the year can either be at the first or last (in numeric form only)
        // the month can either be in the first or second (in numeric or alphabetic)
        // the day can be in any of the three (in numeric form only)

        // YYYY/MM/DD or YYYY/Month/DD
        // MM/DD/YYYY or Month/DD/YYYY
        // DD/MM/YYYY or DD/Month/YYYY
        //including separators --> [./-\s*]
        
        // String monthRegex = "(0[1-9]|1[0-2])";  // For months 01-12
        // String dayRegex = "(0?[1-9]|[12][0-9]|3[01])";  // For days 1-31

        // String dateRegex = "\\b(?:\\w\\s+)?(?:\\w+,?\\s*)?(?:(?:(?:\\d{1,4}|\\w)[/.-])?\\d{1,2}[/.-]\\d{1,4}|\\w+\s+\\d{1,2}(?:st|rd|th|nd)?,?\\s*\\d{4})\\b";

        String dateRegex = "\\b(?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun\\s+)?(?:\\w+,?\\s*)?(?:(?:(?:\\d{1,4}|\\w)[/.-])?\\d{1,2}[/.-]\\d{1,4}|\\w+\s+\\d{1,2}(?:st|rd|th|nd)?,?\\s*\\d{4})\\b";

        Pattern pattern = Pattern.compile(dateRegex);
        Matcher matcher = pattern.matcher(sentence);
        
        // String[] splitSentence = pattern.split(sentence);
        // System.out.println(Arrays.toString(splitSentence));

        if (matcher.find()) {
            return matcher.group().trim();
        } else {
        return "Date Match Not Found!";
        }
    }
                    
}