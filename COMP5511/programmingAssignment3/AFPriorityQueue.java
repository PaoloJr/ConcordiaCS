package COMP5511.programmingAssignment3;

import java.util.Comparator;

/*
*  REQUIRED METHODS
*  state (): returns the current state (Min or Max) of the priority queue. --> done
*  isEmpty(): returns true if the priority queue is empty. --> done
*  size(): returns the current number of entries in the priority queue --> done
*  top(): returns the top entry (with the min or the max key depending whether it is a Min- or Max-priority queue, without removing the entry. --> done
*  removeTop(): removes and returns the entry object (a key, value pair) with the smallest or biggest key --> done
*  remove (e): Removes entry object e from the priority queue and returns the entry depending on the current state of the PQ (either Min or Max).
*  replaceValue (e, v): replace entry e’s value to v and return the old value. --> done
*  replaceKey (e, k): replace entry e’s key to k and return the old key. --> done
*  toggle() transforms a min- to a max-priority queue or vice versa. --> done
*  insert (k,v): insert pair to the PQ, and returns the corresponding entry object in the PQ. --> done
 */

public class AFPriorityQueue <K extends Comparable<K>, V> {
  private AFPQEntry<K, V>[] heap;
  private int size;
  private String currState;
  private final String MIN_HEAP = "Min Heap";
  private final String MAX_HEAP = "Max Heap";

  @SuppressWarnings("unchecked")
  public AFPriorityQueue() {
    heap = (AFPQEntry<K, V>[]) new AFPQEntry[3]; 
    currState = MIN_HEAP;
    size = 0;
  }

  @SuppressWarnings("unchecked")
  public AFPriorityQueue(Comparator<K> comparator) {
    heap = (AFPQEntry<K, V>[]) new AFPQEntry[3]; 
    currState = MIN_HEAP;
    size = 0;
  }  

  public String state() { return currState; }
  public boolean isEmpty() { return size() == 0; }
  public int size() { return size; }
  public AFPQEntry<K, V> top() { return heap[0]; };

  private int parent(int j) { return (j-1) / 2; }  
  private int left(int j) { return 2*j + 1; }
  private int right(int j) { return 2*j + 2; }
  private boolean hasLeft(int j) { return left(j) < size; }
  private boolean hasRight(int j) { return right(j) < size; }

  private void swap(int i, int j) {
    AFPQEntry<K,V> temp = heap[i];
    heap[i] = heap[j];
    heap[j] = temp;
    heap[i].setIndex(i);
    heap[j].setIndex(j);
  }

  // private int compare(AFPQEntry<K,V> a, AFPQEntry<K,V> b) {
  //   return comp.compare(a.getKey(), b.getKey());
  // }  

  // private int compare(AFPQEntry<K, V> a, AFPQEntry<K, V> b) {
  //   int cmp = comp.compare(a.getKey(), b.getKey());
  //   if (currState.equalsIgnoreCase(MAX_HEAP)) {
  //       return -cmp; // Reverse the comparison for max-heap
  //   } else {
  //       return cmp; // Normal comparison for min-heap
  //   }
  // }

  private int compare(K key1, K key2) {
      int cmp = key1.compareTo(key2);
      if (currState.equalsIgnoreCase(MAX_HEAP)) {
          return -cmp; // Reverse the comparison for max-heap
      } else {
          return cmp; // Normal comparison for min-heap
      }
  }  
  
  public AFPQEntry<K, V> insert(K key, V value) throws IllegalArgumentException {  
    if (size == heap.length) { resize(2 * heap.length); }
    if (key == null) { throw new IllegalArgumentException("Key must not be null"); }
    if (value == null) { throw new IllegalArgumentException("Value must not be null"); }

    AFPQEntry<K, V> newest = new AFPQEntry<K, V>(key, value, heap.length);    
    heap[size] = newest;
    upheap(size);
    size++;
    return newest;
  }

  @SuppressWarnings("unchecked")
  public void resize(int capacity) {
    AFPQEntry<K, V>[] temp = new AFPQEntry[capacity];
    for (int i = 0; i < size; i++) {
      temp[i] = heap[i];
    }
    heap = temp;
  }
  
  // public AFPQEntry<K, V>remove(AFPQEntry<K,V> entry) throws IllegalArgumentException {
  //     AFPQEntry<K,V> locator = validate(entry);
  //     int j = locator.getIndex();
  //     if (j == size - 1) {        // entry is at last position
  //       heap[j] = null;  // so just remove it
  //     } else {
  //         // swap entry to last position
  //         swap(j, size - 1);      
  //         // then remove it
  //         heap[size - 1] = null;        
  //         bubble(j);           
  //       }
  //       size--;
  //     }
      
  public AFPQEntry<K, V> removeTop() {
    if (isEmpty()) { return null; }
    AFPQEntry<K, V> topEntry = heap[0];
    swap(0, size - 1);
    heap[size - 1] = null;
    size--;
    downheap(0);
    return topEntry;
  }

  public void toggle() {
    if (currState.equalsIgnoreCase(MAX_HEAP)) {
        currState = MIN_HEAP;
        for (int i = (size / 2) - 1; i >= 0; i--) {
          downheap(i);
      }
    } else {
        currState = MAX_HEAP;
        for (int i = (size / 2) - 1; i >= 0; i--) {
          downheap(i);
        }
      }
  }
      
  public K replaceKey(AFPQEntry<K,V> entry, K key) throws IllegalArgumentException {
    AFPQEntry<K,V> locator = validate(entry);
    K oldKey = locator.getKey();
    K newKey = entry.getKey();

    if (compare(newKey, oldKey) > 0) {
      upheap(locator.getIndex());
    } else {
      downheap(locator.getIndex());
    }
    return oldKey;
  }
              
  public V replaceValue(AFPQEntry<K,V> entry, V value) throws IllegalArgumentException {
    AFPQEntry<K,V> locator = validate(entry);
    V oldValue = locator.getValue();
    locator.setValue(value);
    return oldValue;
  }  
              
  //Moves the entry at index j higher, if necessary, to restore the heap property. 
  private void upheap(int j) {
    while (j > 0) {         
      int p = parent(j);
      if (compare(heap[j].getKey(), heap[p].getKey()) >= 0) {
        break;
      } else {
        swap(j, p);
        j = p; 
      }
    }
  }
  
  /** Moves the entry at index j lower, if necessary, to restore the heap property. */
  private void downheap(int j) {
    while (hasLeft(j)) {               
      int leftIndex = left(j);
      int smallChildIndex = leftIndex; 
      if (hasRight(j)) {
        int rightIndex = right(j);
        if (compare(heap[leftIndex].getKey(), heap[rightIndex].getKey()) > 0) {
          smallChildIndex = rightIndex;          }
        }
        if (compare(heap[smallChildIndex].getKey(), heap[j].getKey()) >= 0) {
          break;                         
        }
        swap(j, smallChildIndex);
        j = smallChildIndex;      
      }
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

  private AFPQEntry<K,V> validate(AFPQEntry<K,V> entry) throws IllegalArgumentException {
    if (!(entry instanceof AFPQEntry)) throw new IllegalArgumentException("Invalid entry: not an instance of AFPQEntry");
    
    AFPQEntry<K,V> locator = (AFPQEntry<K,V>) entry;
    int j = locator.getIndex();
    // if (j >= heap.length) { throw new IllegalArgumentException("Heap is full!"); }
    
    // if(heap[j] != locator) { throw new IllegalArgumentException("Invalid entry, please check key-value pair types"); }   
    
    System.out.println("Validating entry: " + entry);
    System.out.println("Heap size: " + size);
    System.out.println("Heap length: " + heap.length);
    System.out.println("Entry index `j`: " + j);
    
    // if (j >= heap.length) {
    //   System.out.println("Heap is full!");
    //   return null;
    // }
    // if(heap[j] != locator) {
    //   System.out.println("Invalid Entry");
    //   return null;
    // }
  
    // if (j >= heap.length || heap[j] != locator) {
    //  System.out.println("Invalid entry");
    //  return null;
    // }

    if (j >= heap.length || heap[j] != locator)
    throw new IllegalArgumentException("Invalid entry");
    return locator;
  }
  
    /** Used for debugging purposes only */
    // private void sanityCheck() {
    //   for (int j=0; j < heap.size(); j++) {
    //     int left = left(j);
    //     int right = right(j);
    //     if (left < heap.size() && compare(heap.get(left), heap.get(j)) < 0)
    //       System.out.println("Invalid left child relationship");
    //     if (right < heap.size() && compare(heap.get(right), heap.get(j)) < 0)
    //       System.out.println("Invalid right child relationship");
    //   }
    // }
}
          