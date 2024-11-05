package COMP5361.programmingAssignment2;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.Scanner;
// import java.util.Arrays;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class GrammarRegex {

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

    // public static Integer getMonthNumber(String month) {
    //     return months.get(month);
    // }
    
    private static String dateRegex(String sentence) {
        // Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun
        // January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec
        // Jan|Feb|Mar|Apr|May|Jun|June|Jul|July|Aug|Sep|Sept|Oct|Nov|Dec
        
        // the year can either be at the first or last (in numeric form only)
        // the month can either be in the first or second (in numeric or alphabetic)
        // the day can be in any of the three (in numeric form only)

        // YYYY/MM/DD or YYYY/MMM/DD
        // MM/DD/YYYY or MMM/DD/YYYY
        // DD/MM/YYYY or DD/MMM/YYYY
        //including separators --> [./-\s*]

        /*
        tested on regex101.com
        /\b
        ((0?[1-9]|[12][0-9]|3[01])[/.-]|((0?[1-9]|1[0-2])|(Jan|Feb|Mar|Apr|May|Jun|June|Jul|July|Aug|Sep|Sept|Oct|Nov|Dec))[/.-]|((19[0-9]{2}|20[0-9]{2})|(0?[1-9]|[12][0-9]|3[01]))[/.-]?)?
        \b
         */

        // String monthRegex = "(0[1-9]|1[0-2])";  // For months 01-12
        // String dayRegex = "(0?[1-9]|[12][0-9]|3[01])";  // For days 1-31

        // String dateRegex = "\\b(?:\\w\\s+)?(?:\\w+,?\\s*)?(?:(?:(?:\\d{1,4}|\\w)[/.-])?\\d{1,2}[/.-]\\d{1,4}|\\w+\s+\\d{1,2}(?:st|rd|th|nd)?,?\\s*\\d{4})\\b";

        // String dateRegex = 
        // "\\b"
        // +
        // "(?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun\\s+)?" 
        // + 
        // "(?:January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec,?\\s+)?" 
        // +
        // "((([1-9]|[12][0-9]|3[01])(?:st|rd|th|nd))?,?\\s+)?" 
        // + 
        // "((0?[1-9]|[12][0-9]|3[01])[/.-]|((0?[1-9]|1[0-2])|(Jan|Feb|Mar|Apr|May|Jun|June|Jul|July|Aug|Sep|Sept|Oct|Nov|Dec))[/.-]|((19[0-9]{2}|20[0-9]{2})|(0?[1-9]|[12][0-9]|3[01]))[/.-]?)?"
        // +
        // "\\b";
        //  + "(?:(?:(?:\\d{1,4}|\\w)[/.-])?\\d{1,2}[/.-]\\d{1,4}|\\w+\s+\\d{4})\\b";

        String dateRegex = 
            "\\b" // assert position at word boundary
                // + "(?:(?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun),?\\s*)?" // Optional weekday (0 or one times)
                + "(?:" // match everything enclosed
                + "(?:((19|20)\\d{2})[-/.](0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01]))"  // YYYY[/.-]MM[/.-]DD
                + "|((0?[1-9]|[12][0-9]|3[01])[-/.](0?[1-9]|1[0-2])[-/.]((19|20)\\d{2}))"  // DD[/.-]MM[/.-]YYYY
                + "|((0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\\d{2}))"  // MM[/.-]DD[/.-]YYYY
                + "|((19|20)\\d{2})[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.](0?[1-9]|[12][0-9]|3[01])"  // YYYY[/.-]MMM[/.-]DD
                + "|((0?[1-9]|[12][0-9]|3[01])[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]((19|20)\\d{2}))"  // DD[/.-]MMM[/.-]YYYY
                + "|((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]?(0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\\d{2}))"  // MMM[/.-]DD[/.-]YYYY
                + "|(?:"
                + "(?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun),?\\s*)?"  // Optional weekday (0 or one times)
                + "(?:January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec)\\s+"
                + "(\\d{1,2}(?:st|nd|rd|th)?)"  // 1 to 2 digit Day with optional suffix
                + ",?\\s*(\\d{4})"  // Optional comma, then 4-digit year
            + ")\\b";

        Pattern pattern = Pattern.compile(dateRegex);
        // System.out.println(pattern);
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