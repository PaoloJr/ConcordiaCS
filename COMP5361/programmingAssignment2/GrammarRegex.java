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
            if (sentence.contains("*****")){
                out.print("\n");
                out.print("\n");
                out.println("-----*****NON-ACCEPTABLE-FORMATS-BELOW*****-----");
                // out.print("\n");
            } else {
            String phone = phoneNumberRegex(sentence);
            String date = dateRegex(sentence);
                out.println("Sentence: " + sentence);
                out.println("Detected phone number: " + phone);
                out.println("Detected date: " + date);
                out.println();
            }
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
        // String phoneRegex = 
        // "(?:(\\+1[-.\\s]?)?"                   
        // + "\\(?"
        // + "[2-9][0-9]{2}"
        // + "\\)?"
        // + "[-.\\s]?"   
        // + "[2-9][0-9]{2}"
        // + "[-.\\s]?"           
        // + "[0-9]{4})";
        String phoneRegex = 
        "\\(?"
        + "[2-9][0-9]{2}"
        + "\\)?"
        + "[-.\\s]?"   
        + "[2-9][0-9]{2}"
        + "[-.\\s]?"           
        + "[0-9]{4}";

        // Exchange code: first digit 2-9, followed by any two digits and by a single optional dash or period or whitepace
        // anchored optional +1 prefix, followed by single optional dash or period or whitespace
        // Area code: optional open-parentheses, first digit 2-9, followed by any two digits, optional closed-parentheses followed by single optional dash or period or whitepace
        // Subscriber number: any four digits
        
        Pattern pattern = Pattern.compile(phoneRegex);
        Matcher matcher = pattern.matcher(sentence);
        // System.out.println(pattern);
        // System.out.println(matcher);

        while (matcher.find()) {
            String potentialPhone = matcher.group();
            System.out.println("Found potential match: " + potentialPhone);
            
            if (potentialPhone.matches(phoneRegex)) { 
                System.out.println("Full match confirmed for: " + potentialPhone);
                return potentialPhone;
            }
        }
        System.out.println("No valid phone number found in sentence.");
        return "Phone Match Not Found!";
        
        // if (matcher.find()) {
            // System.out.println("Found potential match: " + potentialPhone);            
            //     return matcher.group();
            //     } else {
                // System.out.println("Full match confirmed for: " + potentialPhone);
        //         return "Phone Match Not Found!";
        //     }          

    }
    
    private static String dateRegex(String sentence) {
        // baseline
        // String dateRegex = 
        //     "\\b" 
        //     + "(?:\\w\\s+)?(?:\\w+,?\\s*)?" 
        //     + "(?:"
        //     + "(?:"
        //     + "(?:\\d{1,4}|\\w)[/.-])?\\d{1,2}[/.-]\\d{1,4}|\\w+\s+\\d{1,2}(?:st|rd|th|nd)?,?\\s*\\d{4})" 
        //     + "\\b";

        // Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun
        // January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec
        // Jan|Feb|Mar|Apr|May|Jun|June|Jul|July|Aug|Sep|Sept|Oct|Nov|Dec
        
        
        /*
        tested on regex101.com
        /\b
        ((0?[1-9]|[12][0-9]|3[01])[/.-]|((0?[1-9]|1[0-2])|(Jan|Feb|Mar|Apr|May|Jun|June|Jul|July|Aug|Sep|Sept|Oct|Nov|Dec))[/.-]|((19[0-9]{2}|20[0-9]{2})|(0?[1-9]|[12][0-9]|3[01]))[/.-]?)?
        \b
        */
        
        /*
         the year can either be at the first or last (in numeric form only)
         the month can either be in the first or second (in numeric or alphabetic)
         the day can be in any of the three (in numeric form only)
         YYYY/MM/DD or YYYY/MMM/DD
         MM/DD/YYYY or MMM/DD/YYYY
         DD/MM/YYYY or DD/MMM/YYYY
         including separators --> [./-\s*]
        */
        
        // String dayRegex = "(0?[1-9]|[12][0-9]|3[01])";  // For days 1-31
        // String monthRegex = "(0?[1-9]|1[0-2])";  // For months 01-12
        // String yearRegex = "((19|20)\\d{2})"; // for years from 1900-2099
        
        String dateRegex = 
            "\\b" // assert position at beginning of word boundary
            + "(?:" // match everything enclosed
            + "(?:((19|20)\\d{2})[-/.](0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01]))"  // YYYY[/.-]MM[/.-]DD
            + "|((0?[1-9]|[12][0-9]|3[01])[-/.](0?[1-9]|1[0-2])[-/.]((19|20)\\d{2}))"  // DD[/.-]MM[/.-]YYYY
            + "|((0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\\d{2}))"  // MM[/.-]DD[/.-]YYYY
            + "|((19|20)\\d{2})[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.](0?[1-9]|[12][0-9]|3[01])"  // YYYY[/.-]MMM[/.-]DD
            + "|((0?[1-9]|[12][0-9]|3[01])[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]((19|20)\\d{2}))"  // DD[/.-]MMM[/.-]YYYY
            + "|((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]?(0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\\d{2}))"  // MMM[/.-]DD[/.-]YYYY
            + "|(?:" // match everything enclosed
            + "(?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun),?\\s*)?"  // Optional weekday (0 or one times) followed by optional comma and 0 to many whitespaces
            + "(?:January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec)\\s+"
            + "(\\d{1,2}(?:st|nd|rd|th)?)"  // 1 to 2 digit-Day with optional suffix
            + ",?\\s*(\\d{4})"  // Optional comma, with 0 to multiple whitespaces then 4-digit year
            + ")\\b"; // assert position at end of word boundary

        Pattern pattern = Pattern.compile(dateRegex);
        // System.out.println(pattern);
        Matcher matcher = pattern.matcher(sentence);
        // System.out.println(matcher);
        
        // String[] splitSentence = pattern.split(sentence);
        // System.out.println(Arrays.toString(splitSentence));

        if (matcher.find()) {
            return matcher.group();
        } else {
        return "Date Match Not Found!";
        }
    }
                    
}