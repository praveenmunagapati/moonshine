
-- Coercion

assertTrue (0, 'Zero should coerce to true.')
assertTrue (1, 'Positive number should coerce to true.')
assertTrue (-1, 'Negative number should coerce to true.')
assertTrue ('Test', 'String should coerce to true.')
assertTrue ('', 'Empty string should coerce to true.')

assertTrue (not (nil), 'Nil should coerce to false.')
assertTrue (not (false), 'False should be false.')
assertTrue (not (10 == '10'), 'String should coerce to number.')



-- TYPE ERRORS

function conc (a, b)
	return a..b
end

a = pcall (conc, 'a', 'b')
b = pcall (conc, 'a', 44)
c = pcall (conc, 55, 'b')
d = pcall (conc, 55, 44)
e = pcall (conc, 'a', {})
f = pcall (conc, {}, 'b')
g = pcall (conc, 'a', os.date)

assertTrue (a, 'Concatenation should not error with two strings')
assertTrue (b, 'Concatenation should not error with a string and a number')
assertTrue (c, 'Concatenation should not error with a number and a string')
assertTrue (d, 'Concatenation should not error with two numbers')
assertTrue (not (e), 'Concatenation should error with a string and a table')
assertTrue (not (f), 'Concatenation should error with a table and a string')
assertTrue (not (g), 'Concatenation should error with a string and a function')


function add (a, b)
	return a + b
end

a = pcall (add, 'a', 'b')
b = pcall (add, 'a', 44)
c = pcall (add, 55, 'b')
d = pcall (add, 55, 44)
e = pcall (add, 'a', {})
f = pcall (add, {}, 'b')
g = pcall (add, 'a', os.date)

assertTrue (not (a), 'Addition operator should error with two strings')
assertTrue (not (b), 'Addition operator should error with a string and a number')
assertTrue (not (c), 'Addition operator should error with a number and a string')
assertTrue (d, 'Addition operator should not error with two numbers')
assertTrue (not (e), 'Addition operator should error with a string and a table')
assertTrue (not (f), 'Addition operator should error with a table and a string')
assertTrue (not (g), 'Addition operator should error with a string and a function')


function sub (a, b)
	return a - b
end

a = pcall (sub, 'a', 'b')
b = pcall (sub, 'a', 44)
c = pcall (sub, 55, 'b')
d = pcall (sub, 55, 44)
e = pcall (sub, 'a', {})
f = pcall (sub, {}, 'b')
g = pcall (sub, 'a', os.date)

assertTrue (not (a), 'Subtraction operator should error with two strings')
assertTrue (not (b), 'Subtraction operator should error with a string and a number')
assertTrue (not (c), 'Subtraction operator should error with a number and a string')
assertTrue (d, 'Subtraction operator should not error with two numbers')
assertTrue (not (e), 'Subtraction operator should error with a string and a table')
assertTrue (not (f), 'Subtraction operator should error with a table and a string')
assertTrue (not (g), 'Subtraction operator should error with a string and a function')


function mult (a, b)
	return a * b
end

a = pcall (mult, 'a', 'b')
b = pcall (mult, 'a', 44)
c = pcall (mult, 55, 'b')
d = pcall (mult, 55, 44)
e = pcall (mult, 'a', {})
f = pcall (mult, {}, 'b')
g = pcall (mult, 'a', os.date)

assertTrue (not (a), 'Multiplication operator should error with two strings')
assertTrue (not (b), 'Multiplication operator should error with a string and a number')
assertTrue (not (c), 'Multiplication operator should error with a number and a string')
assertTrue (d, 'Multiplication operator should not error with two numbers')
assertTrue (not (e), 'Multiplication operator should error with a string and a table')
assertTrue (not (f), 'Multiplication operator should error with a table and a string')
assertTrue (not (g), 'Multiplication operator should error with a string and a function')


function divide (a, b)
	return a / b
end

a = pcall (divide, 'a', 'b')
b = pcall (divide, 'a', 44)
c = pcall (divide, 55, 'b')
d = pcall (divide, 55, 44)
e = pcall (divide, 'a', {})
f = pcall (divide, {}, 'b')
g = pcall (divide, 'a', os.date)

assertTrue (not (a), 'Division operator should error with two strings')
assertTrue (not (b), 'Division operator should error with a string and a number')
assertTrue (not (c), 'Division operator should error with a number and a string')
assertTrue (d, 'Division operator should not error with two numbers')
assertTrue (not (e), 'Division operator should error with a string and a table')
assertTrue (not (f), 'Division operator should error with a table and a string')
assertTrue (not (g), 'Division operator should error with a string and a function')


function modu (a, b)
	return a % b
end

a = pcall (modu, 'a', 'b')
b = pcall (modu, 'a', 44)
c = pcall (modu, 55, 'b')
d = pcall (modu, 55, 44)
e = pcall (modu, 'a', {})
f = pcall (modu, {}, 'b')
g = pcall (modu, 'a', os.date)

assertTrue (not (a), 'Modulo operator should error with two strings')
assertTrue (not (b), 'Modulo operator should error with a string and a number')
assertTrue (not (c), 'Modulo operator should error with a number and a string')
assertTrue (d, 'Modulo operator should not error with two numbers')
assertTrue (not (e), 'Modulo operator should error with a string and a table')
assertTrue (not (f), 'Modulo operator should error with a table and a string')
assertTrue (not (g), 'Modulo operator should error with a string and a function')


function power (a, b)
	return a ^ b
end

a = pcall (power, 'a', 'b')
b = pcall (power, 'a', 44)
c = pcall (power, 55, 'b')
d = pcall (power, 55, 44)
e = pcall (power, 'a', {})
f = pcall (power, {}, 'b')
g = pcall (power, 'a', os.date)

assertTrue (not (a), 'Exponentiation operator should error with two strings')
assertTrue (not (b), 'Exponentiation operator should error with a string and a number')
assertTrue (not (c), 'Exponentiation operator should error with a number and a string')
assertTrue (d, 'Exponentiation operator should not error with two numbers')
assertTrue (not (e), 'Exponentiation operator should error with a string and a table')
assertTrue (not (f), 'Exponentiation operator should error with a table and a string')
assertTrue (not (g), 'Exponentiation operator should error with a string and a function')


function neg (a)
	return -a
end

a = pcall (neg, 'a')
b = pcall (neg, 55)
c = pcall (neg, {})

assertTrue (not (a), 'Negation operator should error when passed a string')
assertTrue (b, 'Negation operator should not error when passed a number')
assertTrue (not (c), 'Negation operator should error when passed a table')

