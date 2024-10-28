package COMP5511.programmingAssignment2;


public class ArrayStack<T> implements ArrayStackInterface<T> {
    private T[] elements;
    private int top;
    private static final int INITIAL_CAPACITY = 10;

    @SuppressWarnings("unchecked")
    public ArrayStack() {
        elements = (T[]) new Object[INITIAL_CAPACITY];
        top = -1;
    }

    @Override
    public void push(T value) {
        if (top + 1 == elements.length) {
            resize();
        }
        elements[++top] = value;
    }

    @Override
    public T pop() {
        if (isEmpty()) {
            throw new IllegalStateException("Stack Underflow!");
        }
        T value = elements[top];
        elements[top--] = null; // Avoid memory leaks
        return value;
    }

    @Override
    public T peek() {
        if (isEmpty()) {
            throw new IllegalStateException("Stack is empty!");
        }
        return elements[top];
    }

    @Override
    public boolean isEmpty() {
        return top == -1;
    }

    @Override
    public int size() {
        return top + 1;
    }

    @SuppressWarnings("unchecked")
    private void resize() {
        int newCapacity = elements.length * 2;
        T[] newArray = (T[]) new Object[newCapacity];
        System.arraycopy(elements, 0, newArray, 0, elements.length);
        elements = newArray;
    }
}
