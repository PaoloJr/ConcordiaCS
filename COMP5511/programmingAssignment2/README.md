#### Answers

**a)**

_pseudo-code_
```Java
    Algorithm: Arithmetic
    Input: mathematical expression (including boolean)
    Output: result of calculation

    main {
        // setup HashMap for precedence values of acceptable operators
        // `m` is the number of expressions/lines
        // `n` is the length of each expression/line
        read expressions from file { // O(m * n)
            return expressions // an ArrayList
        }
        for each expression in expressions do {
            evaluateExpressions(expression) {
                tokenizeExpression(expression) { // O(n)
                    return tokens;
                }
                evaluateTokens(tokens) { // O(n), using array-based stacks
                    return result;
                }
            }
            write result to file
        }
        // total time-complexity will need to consider both the number of expressions and their length
        // total time-complexity for processing all expressions --> O(m * n)
    }

    tokenizeExpression(expression) {
        initialize empty ArrayList
        for each character or group in expression do { // O(n) for each expression-line
            ignore whitespace
            if (isNumber (including negative numbers)) then
                add to tokens list
            else if (isOperator or parenthesis) then
                add to tokens list
        }
        return tokens;
        // total time-complexity would be O(m * n)
    }

    evaluateTokens(tokens) {
        initialize empty operandStack and operatorStack // array-based stacks
        for each token in tokens do { // O(n) for each expression-line
            if token isNumber then {
                push token to operandStack
            } else if (token isOpenParenthesis) {
                push token to operatorStack
            } else if (token isClosedParenthesis) {
                while (!operators.isEmpty() && !operatorStack.peek() equals "(") { // O(n)
                    performCalculation(operandStack, operatorStack)
                }
            } else if (token isOperator) then {
                while (!operatorStack.isEmpty() and precedence of operatorStack.peek() >= precedence of current token) do { // O(n)
                    performCalculation(operandStack, operatorStack)
                }
                push token to operatorStack
            }
        }
        while (!operatorStack.isEmpty()) { // O(n)
            performCalculation(operandStack, operatorStack);
        }
        return operandStack.pop(); // returned value from the performCalculation method below
        // total time-complexity would be O(m * n)
    }

    performCalculation(operandStack, operatorStack) {
        int b = operandStack.pop(); // first operand, O(1)
        int a = operandStack.pop(); // second operand, O(1)
        String op = operatorStack.pop(); // operator, O(1)
        
        switch (op) {
                case "+": return operandStack.push(a + b);
                case "-": return operandStack.push(a - b);
                case "*": return operandStack.push(a * b);
                case "/":
                    if (b == 0) throw error ("Cannot divide by zero");
                    return operandStack.push(a / b);
                case "^": return operandStack.push((int) Math.pow(a, b));
                case ">": return operandStack.push(a > b ? 1 : 0);
                case "<": return operandStack.push(a < b ? 1 : 0);
                case ">=": return operandStack.push(a >= b ? 1 : 0);
                case "<=": return operandStack.push(a <= b ? 1 : 0);
                case "==": return operandStack.push(a == b ? 1 : 0);
                case "!=": return operandStack.push(a != b ? 1 : 0);
                default: throw error ("Invalid operator: " + op);
            }
    }
```

**b)** \
[see code](../programmingAssignment2/)


**c) _time and space complexity_** \
	_time complexity_
- using stacks avoids duplicating operations (each token is worked on `push` `pop` exactly one time)
- let `m` be the number of expression-lines and `n` be the length of each expression-line
1. Reading expressions from file (exactly one time) --> `O(m * n)`
2.  tokenizing expressions (examined exactly once)--> `O(m * n)`
	- each character / string is examined exactly one time
	- on individual expressions, it runs `O(n)`, but we need to include overall time-complexity of program; i.e. running across all expressions
3.  evaluating tokens --> `O(m * n)`
	- on individual expressions, it runs `O(n)`, but we need to include overall time-complexity of program; i.e. running across all expressions
	- outer loop --> `O(m * n)`
		- iterates over each token once (since we `push` and `pop` on each token)
	- inner while loops combined --> `O(m * n)`
		- iterates based on operator precedence
	
	_constants ignored for Big-O (asymptotic) analysis_
	$T(n) = O(m * n) + O(m * n) + O(m * n) = O(3(m * n)) = O(m * n)$

    <br>

    _space complexity_
	- if `m` is the number of lines in the file and `n` is the (average) length of each line / expression
	- using `ArrayList` to store all expressions (from file read)		
		- this grows proportionally to the size of the input file (lines of expressions) --> `O(m * n)`
	- using `Stacks` to store `operators` and `operands` of each expression
		- these grow proportionally to the size of the input tokens --> `O(2n)` --> `O(n)`
		- they are used to store expressions one at a time and are cleared after each expression-line is processed
			- thus the space used for processing each expression (line) does not grow with the number of expressions (lines); it does not accumulate
			
		_ignoring static HashMap and intermediate variables since they are not affected by the input_
		$S(n) = O(space \space for \space all \space expressions) + O(space \space for \space processing \space each \space expression))$
		$O(m * n)$ dominates since the space used for processing `O(n)` is negligible compared to the space used to store all expressions, when `m` is large
		$S(n) = O(m * n) + O(n) = O(m * n)$


**d)** \
[input file](../programmingAssignment2/arithmeticIn.txt) \
[output file](../programmingAssignment2/arithmeticOut.txt)
