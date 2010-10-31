# Can assign the result of a try/catch block.
result = try
  nonexistent * missing
catch error
  true

result2 = try nonexistent * missing catch error then true

ok result is true and result2 is true


# Can assign a conditional statement.
getX = -> 10

if x = getX() then 100

ok x is 10

x = if getX() then 100

ok x is 100


# This-assignment.
tester = ->
  @example = -> 'example function'
  this

ok tester().example() is 'example function'


try throw CoffeeScript.tokens 'in = 1'
catch e then eq e.message, 'Reserved word "in" on line 1 cannot be assigned'


num = 10
num -= 5
eq num, 5

num *= 10
eq num, 50

num /= 10
eq num, 5

num %= 3
eq num, 2

val = false
val ||= 'value'
val ||= 'eulav'
eq val, 'value'

val &&= 'rehto'
val &&= 'other'
eq val, 'other'

val = null
val ?= 'value'
val ?= 'eulav'
eq val, 'value'


parent = child: str: 'test'
parent.child.str.=replace /./, 'b'
eq 'best', parent.child.str
parent.child.str[='replace'] /./, 'r'
eq 'rest', parent.child.str


for nonref in ['""', '0', 'f()']
  try ok not CoffeeScript.compile "{k: #{nonref}} = v"
  catch e then eq e.message, "\"#{nonref}\" cannot be assigned."
