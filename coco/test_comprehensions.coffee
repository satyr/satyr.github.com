# Basic array comprehensions.
nums    = (n * n for n in [1, 2, 3] when n % 2 isnt 0)
results = (n * 2 for n in nums)

ok results.join(',') is '2,18'


# Basic object comprehensions.
obj   = {one: 1, two: 2, three: 3}
names = (prop + '!' for prop of obj)
odds  = (prop + '!' for prop, value of obj when value % 2 isnt 0)

ok names.join(' ') is "one! two! three!"
ok odds.join(' ')  is "one! three!"


# Basic range comprehensions.
nums = (i * 3 for i from 1 to 3)
negs = (x for x from -20 to -5*2)
eq nums.concat(negs.slice 0, 3).join(' '), '3 6 9 -20 -19 -18'


# With range comprehensions, you can loop in steps.
eq "#{ x for x from 0 to 9 by  3 }", '0,3,6,9'
eq "#{ x for x from 9 to 0 by -3 }", '9,6,3,0'
eq "#{ x for x from 3*3 to 0*0 by 0-3 }", '9,6,3,0'


# Multiline array comprehension with filter.
evens = for num in [1, 2, 3, 4, 5, 6] when num % 2 is 0
           num *= -1
           num -= 2
           num * -1
eq evens + '', '4,6,8'


# Backward traversing.
odds = (num for num in [0, 1, 2, 3, 4, 5] by -2)
eq odds + '', '5,3,1'


# The in operator still works, standalone.
ok 2 of evens

# all/from/to aren't reserved.
all = from = to = 1


# Nested comprehensions.
multiLiner =
  for x from 3 to 5
    for y from 3 to 5
      [x, y]

singleLiner =
  (([x, y] for y from 3 to 5) for x from 3 to 5)

ok multiLiner.length is singleLiner.length
ok 5 is multiLiner[2][2][1]
ok 5 is singleLiner[2][2][1]


# Comprehensions within parentheses.
result = null
store = (obj) -> result = obj
store (x * 2 for x in [3, 2, 1])

ok result.join(' ') is '6 4 2'


# Closure-wrapped comprehensions that refer to the "arguments" object.
expr = ->
  result = (item * item for item in arguments)

ok expr(2, 4, 8).join(' ') is '4 16 64'


# Fast object comprehensions over all properties, including prototypal ones.
class Cat
  constructor: -> @name = 'Whiskers'
  breed: 'tabby'
  hair:  'cream'

whiskers = new Cat
own = (value for key, value of whiskers)
all = (value for all key, value of whiskers)

ok own.join(' ') is 'Whiskers'
ok all.sort().join(' ') is 'Whiskers cream tabby'


# Comprehensions safely redeclare parameters if they're not present in closest
# scope.
rule = (x) -> x

learn = ->
  rule for rule in [1, 2, 3]

ok learn().join(' ') is '1 2 3'

ok rule(101) is 101

f = -> [-> ok false, 'should cache source']
ok true for k of [f] = f()


# Lenient true pure statements not trying to reach out of the closure
val = for i in [1]
  for j in [] then break
  i
ok val[0] is i


# Comprehensions only wrap their last line in a closure, allowing other lines
# to have pure expressions in them.
func = -> for i in [1, 2]
  break if i is 2
  j for j in [1]
ok func()[0][0] is 1

i = 6
odds = while i--
  continue unless i & 1
  i
eq '5,3,1', '' + odds


# For each dynamic call under `for`,
# define it outside and pass loop variables to it.
fs = for i from 0 to 2 when i > 0
  me = this
  do =>
    return if i < 2
    eq me, this
    eq 1, arguments.length
  do ->
    {callee} = arguments
    -> [i, callee]
[one, two] = (f() for f in fs)
eq one[0], 1
eq two[0], 2
eq one[1], two[1]
