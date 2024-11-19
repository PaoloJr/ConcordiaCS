package COMP5511.programmingAssignment3;

import java.util.Comparator;

/*
*  REQUIRED METHODS
*  removeTop(): removes and returns the entry object (a key, value pair) with the smallest or biggest key
*  depending on the current state of the priority queue (either Min or Max).
*  insert (k,v): Insert (k,v) which is a key(k), value(v) pair to the priority queue, and returns the
*  corresponding entry object in the priority queue.
*  top(): returns the top entry (with the minimum or the maximum key depending on whether it is a
*  Min- or Max-priority queue, without removing the entry.
*  remove (e): Removes entry object e from the priority queue and returns the entry
*  replaceKey (e, k): replace entry e’s key to k and return the old key.
*  replaceValue (e, v): replace entry e’s value to v and return the old value.
*  toggle() transforms a min- to a max-priority queue or vice versa.
*  state (): returns the current state (Min or Max) of the priority queue.
*  isEmpty(): returns true if the priority queue is empty.
*  size(): returns the current number of entries in the priority queue --> done
 */

public class AFPriorityQueue<K, V> {
    // primary collection of priority queue
    private AFPQEntry<K, V>[] heap;
    private int size = 0;
    private int DEFAULT_CAPACITY = 10;
    private Comparator<K> comp;

    public AFPriorityQueue() {

    }

    public int size() { return heap.length; }

    public AFPQEntry<K, V> insert(K key, V value) throws IllegalArgumentException {
        checkKey(key); // may throw an exception
        if (size == heap.length) {
            resize(2 * heap.length);
        }
        AFPQEntry<K, V> newest = new AFPQEntry<K, V>(key, value);
        
        heap[size] = newest;
        upheap(size);
        size++;
        return newest;
    }

   public void resize(int capacity) {
        AFPQEntry<K, V>[] temp = new AFPQEntry[capacity];
        for (int i = 0; i < size; i++) {
            temp[i] = heap[i];
        }
        heap = temp;
    }

    public void swap(int i, int j) {
        AFPQEntry<K,V> temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
      }

    public int compare(AFPQEntry<K,V> a, AFPQEntry<K,V> b) {
        return comp.compare(a.getKey(), b.getKey());
      }

    public boolean checkKey(K key) throws IllegalArgumentException {
        try {
            return (comp.compare(key,key) == 0);  // see if key can be compared to itself
        } catch (ClassCastException e) {
            throw new IllegalArgumentException("Incompatible key");
        }
    }

    public int parent(int j) { return (j-1) / 2; }  

    //Moves the entry at index j higher, if necessary, to restore the heap property. 
    public void upheap(int j) {
    while (j > 0) {            // continue until reaching root (or break statement)
      int p = parent(j);
      if (compare(heap[j], heap[p]) >= 0) break; // heap property verified
      swap(j, p);
      j = p; // continue from the parent's location
    }
  }



}
