package COMP5511.lab2;

public class Factorial {

    public static int runFactorial(int number) {
        if (number == 0) {
          return 1;
        }
        return number * runFactorial(number - 1);
    }

    public static void main(String args[]) {
        int someNumber = 5;
        int result = runFactorial(someNumber);
        System.out.println("Factorial of " + someNumber + " is: " + result);

    }
}