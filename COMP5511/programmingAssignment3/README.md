### Answers

**a)** \
_pseudo-code_

```Java

```

**b)** \
_`toggle()`_
- The non-nested for-loop runs `n/2` times from half the heap's size to index 0, which is `O(n)`.
- The nested call to `downheap(i)` will run `O(log n)` times for each iteration of the loop, since the height of the binary heap is `O(log n)`, where `n` is the number of elements in the heap
- Thus overall, `toggle()` will run in `O(n log n)` time.

_`remove(e)`_

_`replaceKey(e, k)`_
- replacing the key takes `O(1)`, constant-time
- running `upheap()` or `downheap()` as a consequence of comparing the old entry's key with the new one will run `O(log n)` time
- this is because restoring the heap order is completed from the replaced key's subtree; traversing up or down a heap takes logarithmic time relative to the number of elements
- Thus overall, `replaceKey(e, k)` will run `O(log n)` time

_`replaceValue(e, v)`_
- will run `O(1)` times since the getting/setting of the new value will require a constant time of operations and no further update to the heap-order (whether in minHeap or maxHeap) is required.
- this is due to the array-based nature of the heap
    - accessing and updating a value within it runs `O(1)`

