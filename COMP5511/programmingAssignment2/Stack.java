package COMP5511.programmingAssignment2;

import java.util.ArrayList;

class Stack<T> {
    private int top;
    private int capacity;
    private ArrayList<T> arrL;
    
    // Constructor using ArrayList
    public Stack(int size) {
        this.capacity = size;
        arrL = new ArrayList<>(capacity);
        this.top = -1;
    }

    // Push an element onto the stack
    public void push(T item) {
        if (isFull()) {
            System.out.println("Stack is full! Unable to push " + item);
            return;
        }
        arrL.add(++top, item);
    }

    // Pop an element from the stack
    public T pop() {
        if (isEmpty()) {
            System.out.println("Stack is empty! Unable to pop ");
        }
        return arrL.remove(top--);
    }

    // Peek at the top element of the stack
    public T peek() {
        if (isEmpty()) {
            throw new RuntimeException("Stack is empty");
        }
        return arrL.get(top);
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
            System.out.print(arrL.get(i) + " ");
        }
        System.out.println();
    }

    // Clear all elements from the stack
    public void clear() {
        top = -1;
        System.out.println("Stack cleared.");
    }


    public static void main(String[] args) {
        Stack<Integer> stack = new Stack<>(5);

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

