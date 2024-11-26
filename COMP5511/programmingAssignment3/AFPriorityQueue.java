package COMP5511.programmingAssignment3;

import java.util.Comparator;

/*
*  REQUIRED METHODS FOR ADT
*  state (): returns the current state (Min or Max) of the priority queue. --> done
*  isEmpty(): returns true if the priority queue is empty. --> done
*  size(): returns the current number of entries in the priority queue --> done
*  top(): returns the top entry (with the min or the max key depending whether it is a Min- or Max-priority queue, without removing the entry. --> done
*  removeTop(): removes and returns the entry object (a key, value pair) with the smallest or biggest key --> done
*  remove (e): Removes entry object e from the priority queue and returns the entry depending on the current state of the PQ (either Min or Max). --> done
*  replaceValue (e, v): replace entry e’s value to v and return the old value. --> done
*  replaceKey (e, k): replace entry e’s key to k and return the old key. --> done
*  toggle() transforms a min- to a max-priority queue or vice versa. --> done
*  insert (k,v): insert pair to the PQ, and returns the corresponding entry object in the PQ. --> done
 */

public class AFPriorityQueue <K extends Comparable<K>, V> {
  private AFPQEntry<K, V>[] heap;
  private int size;
  private String currState;
  private final String MIN_HEAP = "minHeap";
  private final String MAX_HEAP = "maxHeap";

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
  public AFPQEntry<K, V> top() { 
    if (heap.length == 0) {
      return null;
    }
    AFPQEntry<K, V> found = validate(heap[0]);
    if (found != null) {   
      return heap[0]; 
    }
    
    return heap[0];
  };

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

  public int compare(K key1, K key2) {
      int cmp = key1.compareTo(key2);
      if (currState.equalsIgnoreCase(MAX_HEAP)) {
          return -cmp; // Reverse the comparison for max-heap
      } else {
          return cmp; // Normal comparison for min-heap
      }
  }  
  
  // insert will run O(1)
  // the required upheap method will run O(log n) times
  public AFPQEntry<K, V> insert(K key, V value) throws IllegalArgumentException {  
    // if array of AFPQEntries has reached it's capacity, double its size
    if (size == heap.length) { resize(2 * heap.length); }
    if (key == null) { throw new IllegalArgumentException("Key must not be null"); }
    if (value == null) { throw new IllegalArgumentException("Value must not be null"); }

    AFPQEntry<K, V> newest = new AFPQEntry<>(key, value, heap.length);    
    heap[size] = newest;
    newest.setIndex(size);
    upheap(size);
    size++;
    return newest;
  }

  // will run O(n) as all values are placed in the temp AFPQ-array
  @SuppressWarnings("ManualArrayToCollectionCopy")
  public void resize(int capacity) {
    @SuppressWarnings("unchecked")
    AFPQEntry<K, V>[] temp = new AFPQEntry[capacity];
    for (int i = 0; i < size; i++) {
      temp[i] = heap[i];
    }
    heap = temp;
  }
  
  // swap() runs in constant time --> O(1)
  // downheap(j) runs in O(log n) time to restore the heap order from that removal
  // upheap(j) run in O(log n) time to restore the heap order from that removal
  public AFPQEntry<K, V> remove(AFPQEntry<K,V> entry) throws IllegalArgumentException {
      AFPQEntry<K,V> locator = validate(entry);
      int j = locator.getIndex();
      // if entry is at last position, just remove it; no order change
      if (j == size - 1) {        
        heap[j] = null; 
      } else {
          // swap entry to last position
          swap(j, size - 1); 
          // then remove it
          heap[size - 1] = null;        
          downheap(j);
          upheap(j);
        }
        size--;
        return entry;
  }
      
  // removing the top (the swap) --> O(1)
  // downheap within the method --> O(log n) times
  public AFPQEntry<K, V> removeTop() {
    if (isEmpty()) { return null; }
    AFPQEntry<K, V> topEntry = heap[0];
    swap(0, size - 1);
    heap[size - 1] = null;
    size--;
    downheap(0);
    return topEntry;
  }

  // O(n log n) to rebuild the entire Heap
  // toggle will run O(n) times
  // downheap within toggle will run O(log n) times to restore the heap order (minHeap or maxHeap)
  public void toggle() {
    if (currState.equalsIgnoreCase(MAX_HEAP)) {
        currState = MIN_HEAP;
        for (int i = size - 1; i >= 0; i--) {
          downheap(i);
      }
    } else {
        currState = MAX_HEAP;
        for (int i = size - 1; i >= 0; i--) {
          downheap(i);
        }
      }
    }

  // Moves the entry at index j higher, if necessary, to restore the heap property.
  // This method is used when the current entry is smaller than its parent in a min-heap
  // or larger than its parent in a max-heap.
  // upheap runs in O(log n) time as it may need to traverse the height of the heap.
  // swap runs in O(1) time
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

  // Moves the entry at index j lower, if necessary, to restore the heap property.
  // This method is used when the current entry is larger than its children in a min-heap
  // or smaller than its children in a max-heap.
  // downheap runs in O(log n) time as it may need to traverse the height of the heap.
  // compare and swap (within the downheap function) runs in O(1) time
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

  // replacing the key takes constant time --> O(1)
  // running either upheap() or downheap(), after comparing keys (new key with old key) will run O(log n) time to restore heap-order (minHeap or maxHeap)
  public K replaceKey(AFPQEntry<K,V> entry, K key) throws IllegalArgumentException {
    AFPQEntry<K,V> locator = validate(entry);
    K oldKey = locator.getKey();
    K newKey = key;
    locator.setKey(newKey);

    if (compare(newKey, oldKey) > 0) {
      upheap(locator.getIndex());
    } else {
      downheap(locator.getIndex());
    }
    return oldKey;
  }
              
  // replace value will run O(1) times
  // does not need to rebuild the heap-order (minHeap or maxHeap)
  public V replaceValue(AFPQEntry<K,V> entry, V value) throws IllegalArgumentException {
    AFPQEntry<K,V> locator = validate(entry);
    V oldValue = locator.getValue();
    locator.setValue(value);
    return oldValue;
  }                
  
  @Override
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

  // check if entry is valid and/or key-value pairs are non-null
  private AFPQEntry<K,V> validate(AFPQEntry<K,V> entry) throws IllegalArgumentException {
    if (!(entry instanceof AFPQEntry)) throw new IllegalArgumentException("Invalid entry: not an instance of AFPQEntry or heap is empty");
    
    AFPQEntry<K,V> locator = (AFPQEntry<K,V>) entry;
    int j = locator.getIndex();
    if (j >= size || heap[j] != locator) {
      throw new IllegalArgumentException("Invalid entry: entry not found in the heap");
  }
  if (heap[j].getKey() == null) {
      throw new IllegalArgumentException("Invalid entry: key must not be null");
  }
  if (heap[j].getValue() == null) {
      throw new IllegalArgumentException("Invalid entry: value must not be null");
  }

    // if (j >= heap.length || heap[j] != locator)
    // throw new IllegalArgumentException("Invalid entry");
    return locator;
  }
  
  /** Used for debugging purposes only */
  // public void sanityCheck() {
    //   for (int j=0; j < heap.length; j++) {
      //     int left = left(j);
      //     int right = right(j);
      //     if (left < heap.length && heap[left] != null && comparEntries(heap[left], heap[j]) < 0)
  //       System.out.println("Invalid left child relationship");
  //     if (right < heap.length && heap[right] != null && comparEntries(heap[right], heap[j]) < 0)
  //       System.out.println("Invalid right child relationship");
  //   }
  // }

  // private int comparEntries(AFPQEntry<K,V> a, AFPQEntry<K,V> b) {
  //   return compare(a.getKey(), b.getKey());
  // }
}
          