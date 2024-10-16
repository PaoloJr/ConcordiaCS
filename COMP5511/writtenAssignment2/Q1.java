package COMP5511.writtenAssignment2;

public class Q1 {
    private static int stepsCount;

    static void towerOfHanoi(int disks, char firstPeg, char secondPeg, char thirdPeg, int steps) {
        stepsCount = steps;
        // base case
        if (disks == 1) {
            System.out.println("Step #" + stepsCount + "\nMove disk " + disks + " from rod " + firstPeg + " to " + secondPeg);
            stepsCount++;
            System.out.println("Step #" + stepsCount + "\nMove disk " + disks +  " from rod " + secondPeg + " to " + thirdPeg);
            stepsCount++;
            return;
        }

        // move disks from first peg to last peg
        towerOfHanoi(disks - 1, firstPeg, secondPeg, thirdPeg, stepsCount);
        System.out.println("Step #" + stepsCount + "\nMove disk " + disks + " from rod " + firstPeg + " to " + secondPeg);
        stepsCount++;

        // move disks from last peg to first peg
        towerOfHanoi(disks - 1, thirdPeg, secondPeg, firstPeg, stepsCount);
        System.out.println("Step #" + stepsCount + "\nMove disk " + disks + " from rod " + secondPeg + " to " + thirdPeg);
        stepsCount++;

        // move disks from first peg to last peg
        towerOfHanoi(disks - 1, firstPeg, secondPeg, thirdPeg, stepsCount);
        
    }

    public static void main(String[] args) {
        int disks = 3;
        int steps = 0;
        towerOfHanoi(disks, 'A', 'B', 'C', steps);
        System.out.println("Steps Count = " + stepsCount);
    }
}