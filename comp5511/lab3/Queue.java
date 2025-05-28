package COMP5511.lab3;

class QueueArray {
    private int[] arr;
    private int front, rear, size, capacity;

    public QueueArray(int capacity) {
        this.capacity = capacity;
        arr = new int[capacity];
        front = 0;
        rear = -1;
        size = 0;
    }

    // Enqueue operation: Add an element to the rear of the queue
    public void enqueue(int value) {
        if (isFull()) {
            System.out.println("Queue is full");
            return;
        }
        rear = (rear + 1) % capacity; // Circular increment
        arr[rear] = value;
        size++;
    }

    // 9,0,3 ,4 , 5,6,8

    // Dequeue operation: Remove and return the front element of the queue
    public int dequeue() {
        if (isEmpty()) {
            throw new RuntimeException("Queue is empty");
        }
        int value = arr[front];
        front = (front + 1) % capacity; // Circular increment
        size--;
        return value;
    }

    // Peek operation: Return the front element without removing it
    public int peek() {
        if (isEmpty()) {
            throw new RuntimeException("Queue is empty");
        }
        return arr[front];
    }

    // Check if the queue is empty
    public boolean isEmpty() {
        return size == 0;
    }

    // Check if the queue is full
    public boolean isFull() {
        return size == capacity;
    }

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
