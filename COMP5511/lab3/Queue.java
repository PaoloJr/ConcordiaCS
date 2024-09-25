package COMP5511.lab3;

public class Queue {

    private int[] intArray;
    private int intArraySize;
    private int front = 0;
    private int back = intArraySize - 1;

    public Queue(){
        intArray = new int[100];
        intArraySize = intArray.length;
    }

    public void enqueue(int someInt) {
        if (intArraySize > 0) {
            intArray[back] = someInt;
            intArraySize--;
        }

    }

    public void dequeue(int someInt) {
    }

    public void isFull() {
        if (intArraySize > intArray.length) {
            System.out.println("Stack Overflow! Queue is full!");
        }
    }

    public void isEmpty() {
        if (intArraySize == 0) {
            System.out.println("Stack Underflow! Queue is empty!");
        }
    }

    public static void main(String[] args) {
        Queue q = new Queue();
    }
}