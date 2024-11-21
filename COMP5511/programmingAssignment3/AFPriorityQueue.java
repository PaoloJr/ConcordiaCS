package COMP5511.programmingAssignment3;

import java.util.Comparator;

import COMP5511.dataStructures_textbook.DefaultComparator;

/*
*  REQUIRED METHODS
*  state (): returns the current state (Min or Max) of the priority queue. --> done
*  isEmpty(): returns true if the priority queue is empty. --> done
*  size(): returns the current number of entries in the priority queue --> done
*  removeTop(): removes and returns the entry object (a key, value pair) with the smallest or biggest key
*  remove (e): Removes entry object e from the priority queue and returns the entry depending on the current state of the PQ (either Min or Max).
*  insert (k,v): insert pair to the PQ, and returns the corresponding entry object in the PQ. --> done
*  top(): returns the top entry (with the min or the max key depending whether it is a Min- or Max-priority queue, without removing the entry. --> done
*  replaceKey (e, k): replace entry e’s key to k and return the old key.
*  replaceValue (e, v): replace entry e’s value to v and return the old value. --> done
*  toggle() transforms a min- to a max-priority queue or vice versa.
 */

public class AFPriorityQueue<K, V> {
  private AFPQEntry<K, V>[] heap;
  private Comparator<K> comp;
  private int size;
  private String currState;
  private final String MIN_HEAP = "Min Heap";
  private final String MAX_HEAP = "Max Heap";

  @SuppressWarnings("unchecked")
  public AFPriorityQueue() {
    heap = (AFPQEntry<K, V>[]) new AFPQEntry[3]; 
    comp = new DefaultComparator<>();   
    currState = MIN_HEAP;
    size = 0;
  }

  @SuppressWarnings("unchecked")
  public AFPriorityQueue(Comparator<K> comparator) {
    heap = (AFPQEntry<K, V>[]) new AFPQEntry[3]; 
    comp = comparator;   
    currState = MIN_HEAP;
    size = 0;
  }  

  public String state() { return currState; }
  public boolean isEmpty() { return size() == 0; }
  public int size() { return size; }
  public AFPQEntry<K, V> top() { return heap[0]; };

  public int parent(int j) { return (j-1) / 2; }  
  private int left(int j) { return 2*j + 1; }
  private int right(int j) { return 2*j + 2; }
  private boolean hasLeft(int j) { return left(j) < heap.length; }
  private boolean hasRight(int j) { return right(j) < heap.length; }

  private void swap(int i, int j) {
    AFPQEntry<K,V> temp = heap[i];
    heap[i] = heap[j];
    heap[j] = temp;
  }

  private int compare(AFPQEntry<K,V> a, AFPQEntry<K,V> b) {
    return comp.compare(a.getKey(), b.getKey());
  }
    
  public String toString() {
    StringBuilder sb = new StringBuilder();

    sb.append("[");
    for (int i = 0; i < size; i++) {
      sb.append(heap[i]);

      if (i < size - 1) {
        sb.append(",");
      }
    }
    sb.append("]");
    
    return sb.toString();
  }
  
  public AFPQEntry<K, V> insert(K key, V value) throws IllegalArgumentException {  
    if (size == heap.length) {
        resize(2 * heap.length);
    }
    AFPQEntry<K, V> newest = new AFPQEntry<K, V>(key, value);    
    heap[size] = newest;
    upheap(size);
    size++;
    return newest;
  }
  
  // public AFPQEntry<K, V>remove(AFPQEntry<K,V> entry) throws IllegalArgumentException {
  //   AFPQEntry<K,V> locator = validate(entry);
  //   int j = locator.getIndex();
  //   if (j == size - 1) {        // entry is at last position
  //     heap[j] = null;  // so just remove it
  //   } else {
  //     swap(j, size - 1);      // swap entry to last position
  //     heap[size - 1] = null;  // then remove it
  //     bubble(j);                     // and fix entry displaced by the swap
  //   }
  //   size--;
  // }

  public AFPQEntry<K, V> removeTop() {
    if (isEmpty()) {
        return null;
      }
      AFPQEntry<K, V> topEntry = heap[0];
      System.out.println("heap[0]" + heap[0]);
      System.out.println("heap[size - 1] before swap" + heap[size - 1]);
      swap(0, size - 1);
      System.out.println("heap[size - 1] after swap" + heap[size - 1]);
      heap[size - 1] = null;
      size--;
      System.out.println("heap[0] before downheap" + heap[0]);
      downheap(0);
      System.out.println("heap[0] after downheap" + heap[0]);
      return topEntry;
    }

  // public void toggle() {
  //   if (currState.equalsIgnoreCase(MAX_HEAP)) {
  //     currState = MIN_HEAP;
  //   } else {
  //     currState = MAX_HEAP;
  //   }
  //   rebuildHeap();
  // }

  // private void rebuildHeap() {

  // }
  
  // public void replaceKey(AFPQEntry<K,V> entry, K key) throws IllegalArgumentException {
  //   AFPQEntry<K,V> locator = validate(entry);
    
  //   locator.setKey(key);             // method inherited from PQEntry
  //   bubble(locator.getIndex());      // with new key, may need to move entry
  // }
  
  public V replaceValue(AFPQEntry<K,V> entry, V value) throws IllegalArgumentException {
    AFPQEntry<K,V> locator = validate(entry);
    V oldValue = locator.getValue();
    locator.setValue(value);
    return oldValue;
  }  
  
  //Moves the entry at index j higher, if necessary, to restore the heap property. 
  private void upheap(int j) {
    while (j > 0) {            // continue until reaching root (or break statement)
      int p = parent(j);
      if (compare(heap[j], heap[p]) >= 0) {
         break;
       } else {
          swap(j, p);
          j = p; 
       }
    }
  }
  
  /** Moves the entry at index j lower, if necessary, to restore the heap property. */
  private void downheap(int j) {
    while (hasLeft(j)) {               // continue to bottom (or break statement)
      int leftIndex = left(j);
      int smallChildIndex = leftIndex;     // although right may be smaller
      if (hasRight(j)) {
        int rightIndex = right(j);
        if (compare(heap[leftIndex], heap[rightIndex]) > 0) {
          smallChildIndex = rightIndex;  // right child is smaller
        }
      }
      if (compare(heap[smallChildIndex], heap[j]) >= 0) {
        break;                             // heap property has been restored
      }
      swap(j, smallChildIndex);
      j = smallChildIndex;                 // continue at position of the child
    }
  }

  // private void heapify() {
  //   int startIndex = parent(size() - 1);    // start at PARENT of last entry
  //   for (int j = startIndex; j >= 0; j--) {   // loop until processing the root
  //     downheap(j);
  //   }
  // }

  // private void bubble(int j) {
  //   if (j > 0 && compare(heap[j], heap[parent(j)]) < 0) {
  //     upheap(j);
  //   } else {
  //     downheap(j);
  //   }
  // }
  
  @SuppressWarnings("unchecked")
  public void resize(int capacity) {
    AFPQEntry<K, V>[] temp = new AFPQEntry[capacity];
    for (int i = 0; i < size; i++) {
        temp[i] = heap[i];
    }
    heap = temp;
  }

  public AFPQEntry<K,V> validate(AFPQEntry<K,V> entry) throws IllegalArgumentException {
    if (!(entry instanceof AFPQEntry)) throw new IllegalArgumentException("Invalid entry");
    
    AFPQEntry<K,V> locator = (AFPQEntry<K,V>) entry;
    int j = -1;
    for (int i = 0; i < heap.length; i++) {
        if (heap[i] == locator) {
            j = i;
            break;
        }
    }
    if (j == -1) {
      throw new IllegalArgumentException("Invalid entry");
    }
    return locator;
  }

}
