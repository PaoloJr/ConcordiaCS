package COMP5511.lab3;

public class Main {
    public static void main(String[] args) {

        QueueArray queue = new QueueArray(5);

        queue.enqueue(10);
        queue.enqueue(20);
        queue.enqueue(30);
        System.out.println("Front element: " + queue.peek());  // Output: 10

        System.out.println("Dequeued: " + queue.dequeue());  // Output: 10
        System.out.println("Dequeued: " + queue.dequeue());  // Output: 20

        System.out.println("Is queue empty? " + queue.isEmpty());  // Output: false
    }
}