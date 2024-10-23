package COMP5511.programmingAssignment2;

import java.util.ArrayList;

class Stack {
    private int[] arr;
    private int top;
    private int capacity;
    private ArrayList<String> arrL;

    // Constructor using ArrayList
    public Stack() {
        arrL = new ArrayList<String>();
    }

    // Constructor to initialize the stack with a given capacity
    public Stack(int size) {
        arr = new int[size];
        capacity = size;
        top = -1;
    }

    // Push an element onto the stack
    public void push(int value) {
        if (isFull()) {
            System.out.println("Stack Overflow! Unable to push " + value);
            return;
        }
        arr[++top] = value;
    }

    // Pop an element from the stack
    public int pop() {
        if (isEmpty()) {
            System.out.println("Stack Underflow!");
            return -1;
        }
        return arr[top--];
    }

    // Peek at the top element of the stack
    public int peek() {
        if (!isEmpty()) {
            return arr[top];
        } else {
            System.out.println("Stack is empty!");
            return -1;
        }
    }

    // Return the number of elements in the stack
    public int size() {
        return top + 1;
    }

    // Check if the stack is empty
    public boolean isEmpty() {
        return top == -1;
    }

    // Check if the stack is full
    public boolean isFull() {
        return top == capacity - 1;
    }

    // Display all elements in the stack
    public void display() {
        if (isEmpty()) {
            System.out.println("Stack is empty");
            return;
        }

        for (int i = 0; i <= top; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }

    // Clear all elements from the stack
    public void clear() {
        top = -1;
        System.out.println("Stack cleared.");
    }


    public static void main(String[] args) {
        Stack stack = new Stack(5);

        stack.push(10);
        stack.push(20);
        stack.push(30);

        stack.display(); // Output: 10 20 30

        System.out.println("Peek: " + stack.peek()); // Output: Peek: 30

        stack.pop();
        stack.display(); // Output: 10 20

        System.out.println("Stack Size: " + stack.size()); // Output: Stack Size: 2
    }
}

