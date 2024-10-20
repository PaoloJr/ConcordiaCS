package COMP5511.writtenAssignment2;

public class Q1 {
    private static int stepsCount;
    private static int recursiveCallCount;

    static void towerOfHanoi(int disks, char firstPeg, char secondPeg, char thirdPeg, int steps) {
        stepsCount = steps; // O(1)
        // base case
        if (disks == 1) {
            System.out.println("Step #" + stepsCount + "\nMove disk " + disks + " from rod " + firstPeg + " to " + secondPeg); // O(1)
            stepsCount++; // O(1)
            System.out.println("Step #" + stepsCount + "\nMove disk " + disks +  " from rod " + secondPeg + " to " + thirdPeg); // O(1)
            stepsCount++; // O(1)
            return;
        }
        
        // move disks from first peg to second peg
        // System.out.println("First call");
        recursiveCallCount++;
        // System.out.println("recursiveCallCount: " + recursiveCallCount);
        towerOfHanoi(disks - 1, firstPeg, secondPeg, thirdPeg, stepsCount); // T(n - 1)
        System.out.println("Step #" + stepsCount + "\nMove disk " + disks + " from rod " + firstPeg + " to " + secondPeg); // O(1)
        stepsCount++; // O(1)
        
        // move disks from last peg to first peg
        // System.out.println("Second call");
        recursiveCallCount++;
        // System.out.println("recursiveCallCount: " + recursiveCallCount);
        towerOfHanoi(disks - 1, thirdPeg, secondPeg, firstPeg, stepsCount); // T(n - 1)
        System.out.println("Step #" + stepsCount + "\nMove disk " + disks + " from rod " + secondPeg + " to " + thirdPeg); // O(1)
        stepsCount++; // O(1)
        
        // move disks from first peg to last peg
        // System.out.println("Third call");
        recursiveCallCount++;
        // System.out.println("recursiveCallCount: " + recursiveCallCount);
        towerOfHanoi(disks - 1, firstPeg, secondPeg, thirdPeg, stepsCount); // T(n - 1)        
    }

    public static void main(String[] args) {
        int disks = 3;
        int steps = 0;
        towerOfHanoi(disks, 'A', 'B', 'C', steps);
        System.out.println("Steps Count = " + stepsCount);
        System.out.println("Recursive call count = " + recursiveCallCount);
    }
}