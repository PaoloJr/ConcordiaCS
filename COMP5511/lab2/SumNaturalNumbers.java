package COMP5511.lab2;

public class SumNaturalNumbers {

    public static int sum(int number) {
        if (number == 0) {
           return 0;
        }
        return number + sum(number - 1);
    }

    public static void main(String args[]) {
        int someNumber = 5;
        int result = sum(someNumber);
        System.out.println("Sum of numbers up to " + someNumber + " is: " + result);

    }
}
