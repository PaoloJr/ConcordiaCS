### Answers

**a)** \
_pseudo-code_

```Java

function top() {
    if (heap size == 0) {
        return null;
    }
    return heap[0]; // --> the heap (dynamic array at index 0)
}

function size() {
    return size;
    // size is created when the AFPriorityQueue object is created
    // and incremented / decremented when insert / remove (or removeTop) are called
}

function isEmpty() {
    if (size() == 0) {
        return true;
    }
    return false;
}

function state() {
    return currState;
    // currState (the current state of the heap) is initially set as minHeap
    // and switched once the toggle() function is called
}

function toggle() {
    if (currState is `maxHeap`) {
        update currState to `minHeap`
        for (from (size / 2) - 1 to i >= 0; i--) {
            downheap(i);
        }
    } else {
            update currState to `maxHeap`
            for (from (size / 2) - 1 to i >= 0; i--) {
            downheap(i);
        }
    }
    // downheap(i) will check the left and right child of the node, compare their respective key magnitude and swap if necessary
    // depending on the heap-order (minHeap or maxHeap) as determined by the compare() function
}

function downheap(index j) {
    while(hasLeft(j)) { // while the current index has a left child node
        leftIndex = left(j)
        rightIndex = right(j)
        smallChildIndex = leftIndex
        if (hasRight(j)) {
            // compare will return a positive or negative number, depending on currState
            if (compare(heap at leftIndexKey, heap at rightIndexKey) > 0) {
                update smallChildIndex with rightIndex
            }
            if(compare(heap at smallChildIndexKey, heap at `j` key) >= 0) {
                break;
            }
        }
        swap(j, smallChildIndex);
        j = smallChildIndex
    }
}

fuction upheap(index j) {
    while (j > 0) { // while `j` is not the root
        p = parent(j)
        // compare will return a positive or negative number, depending on currState
        if (compare(heap at `j` key, heap at `p` key) >= 0) {
            break
        } else {
            swap(j, p)
            j = p
        }
    }
}
 
function swap(int i, int j) {
    // swapping the nodes here and updating their respective index
    create temporary (`temp`) entry at `i` (`heap[i]`)
    heap[i] = heap[j];
    heap[j] = temp;
    heap[i].setIndex(i);
    heap[j].setIndex(i); 
}



```

**b)** \
**note** \
_`downheap()` and `upheap()` use the `compare(key1, key2)` method which adjusts the output of the comparison based on the heap-type (`minHeap` or `maxHeap`)_

<br>

_`toggle()`_
- The non-nested for-loop runs `n/2` times from half the heap's size to index 0, which is `O(n)`.
- The nested call to `downheap(i)` will run `O(log n)` times for each iteration of the loop, since the height of the binary heap is `O(log n)`, where `n` is the number of elements in the heap
- Thus overall, `toggle()` will run in `O(n log n)` time.

<br>

_`remove(e)`_
- the `swap()` of existing entry and last entry runs in constant time, `O(1)`
- after the swap, removing the last value runs in constant time, `O(1)`
- calling `downheap()`, to restore the heap order runs in `O(log n)` time
    - in `minHeap`, this is used when the current key is larger than it's children
    - in `maxHeap`, this is used when the current key is smaller than it's children
- calling `upheap()`, to restore the heap order runs in `O(log n)` time
    - in `minHeap`, this is used when the current key is smaller than it's parent
    - in `maxHeap`, this is used when the current key is larger than it's parent
- Overall, `remove(e)` runs in `O(log n)` time, as the dominant operations are the disjoint calls to `upheap()` and `downheap()`

<br>

_`replaceKey(e, k)`_
- replacing the key takes `O(1)`, constant-time
- running `upheap()` or `downheap()` as a consequence of comparing the old entry's key with the new one will run `O(log n)` time
- this is because restoring the heap order is completed from the replaced key's subtree; traversing up or down a heap takes logarithmic time relative to the number of elements
- Thus overall, `replaceKey(e, k)` will run `O(log n)` time

<br>

_`replaceValue(e, v)`_
- will run `O(1)` times since the getting/setting of the new value will require a constant time of operations and no further update to the heap-order (whether in minHeap or maxHeap) is required.
- this is due to the array-based nature of the heap
    - accessing and updating a value within it runs `O(1)`



**c)** \
[see code](../programmingAssignment3/)
