package COMP5511.programmingAssignment3;

public class AFPQEntry<K, V> {
    private K k; 
    private V v;
    private int index;

    public AFPQEntry(K key, V value, int index) {
        this.k = key;
        this.v = value;
        this.index = index;
    }    

    public String toString() { return "(" + k + "," + v + ")"; }
    public K getKey() { return k; }
    public V getValue() { return v; }

    public void setKey(K key) { k = key; }
    public void setValue(V value) { v = value; }

    public int getIndex() { return index; }
    public int setIndex(int newIndex) { return this.index = newIndex; }
}
