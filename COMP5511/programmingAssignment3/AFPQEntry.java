package COMP5511.programmingAssignment3;

public class AFPQEntry<K, V> {
    private K k;  // key
    private V v;  // value
    
    public AFPQEntry(K key, V value) {
        k = key;
        v = value;
    }

    public K getKey() { return k; }
    public V getValue() { return v; }
}
