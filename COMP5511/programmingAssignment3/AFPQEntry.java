package COMP5511.programmingAssignment3;

public class AFPQEntry<K, V> {
    private K k; 
    private V v;
    // private int index; // entry's current index within the heap

    // empty entry
    public AFPQEntry() {
        this(null, null);
    }
    
    public AFPQEntry(K key, V value) {
        k = key;
        v = value;
    }    
    
    // public AFPQEntry(K key, V value, int j) {
    //     k = key;
    //     v = value;
    //     index = j;    // this sets the new field
    // }

    public String toString() { return "(" + k + "," + v + ")"; }
    public K getKey() { return k; }
    public V getValue() { return v; }

    public void setKey(K key) { k = key; }
    public void setValue(V value) { v = value; }

    // public int getIndex() { return index; }
    // public void setIndex(int j) { index = j; }
}
