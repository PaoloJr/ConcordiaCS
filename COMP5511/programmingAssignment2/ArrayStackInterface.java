package COMP5511.programmingAssignment2;

public interface ArrayStackInterface<T> {
    void push(T value);
    T pop();
    T peek();
    boolean isEmpty();
    int size();
}
