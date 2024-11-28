### Answers
due to time constraints, I had to limit `BinaryFib` up to the value of 45 (`BinaryFib(45)`) since it would take over 10 minutes to execute `BinaryFib(50)` - $O(2^n)$ \
the others, `LinearFib` and `TRLinearFib` could go up to 100 within an acceptable execution timeframe due to their improved time-complexity $O(n)$

**a)** \
[see code](../pa1/) 

**b)** \
the first algorithm, `BinaryFib`,  starts two recursive calls, thus creating a tree of sub-recursive calls for the two preceding values (`n - 1` and `n - 2`), all the way down the tree, until the value being evaluated equals 1 or 0. 
This adds duplicate/redundant calls onto the stack, for example: 
`binaryFib(5)`, calls `binaryFib(4)` and `binaryFib(3)`
and
`binaryFib(4)`, calls `binaryFib(3)` and `binaryFib(2)`
`binaryFib(3)` is called twice thus creating duplication of tree-nodes in the recursive execution; each subsequent recursive call needs to call the individual (sub) recursive calls.
this leads to an exponential time complexity $O(2^n)$

the second algorithm, `LinearFib`, greatly improves execution performance / time-complexity (to O(n)) by making only one recursive call (_linear recursion_) onto the stack, that outputs an array of the individual values (`n - 1`, `n - 2`) for which we simply add those two values
this avoids having the algorithm recompute (second recursive call) the second value that is already known; there is only one recursive call and there are no duplicate / redundant recursive calls.

**c)** \
neither of the two algorithms use _tail recursion_; tail-recursion requires that the very last function operation be a recursive call - the return value (if any) is immediately returned by the recursive call
1. `BinaryFib` completes two recursive calls at the end and adds the two (an extra operation / computation)
	- `binaryFibonacci(n.subtract(BigInteger.ONE)).add(binaryFibonacci(n.subtract(BigInteger.TWO)));` 
2. `LinearFib` has additional operations done to the return array of the recursive call `BigInteger[] temp = linearFibonacci(n - 1);`
	- `BigInteger[] result = {temp[0].add(temp[1]), temp[0], temp[1]};`
tail recursion necessitates being linear recursive first since it would need to essentially make a single recursive call; in our example, using `LinearFib`, we will return the value immediately, thus making the recursive call the very last operation
for this to work, we will add some arguments to the initial linear-recursive function. One will handle the next position (reassignment) and one for accumulating (sum) of the previous values (reassignment)

[see TRLinearFib](../pa1/TRLinearFib.java)

#### pseudo-code

```Java
// Algorithm: TRLinearFibonnaci(n, a, b)
// Input: int, zero-value (0) - on first call, one-value (1) - on first call
// Output: BigInteger - value from the computation (Fibonacci value)
	if (n <= 1) {
		return b;
	} else {
		return TRLinearFibonnacci(n - 1, b, a + b);
	}
// n - 1 to recursively call for the preceding value
// when `n` becomes 1, we return the accumulated value; ex: TRLinearFib(5), would be the sum of 2 + 3
// parameter `b` takes the position of argument `a`, reassignment
// argument `b` is the acumulator, storing the sum of the preceding two values (the values a & b from the previous recursive call) - reassignment
```