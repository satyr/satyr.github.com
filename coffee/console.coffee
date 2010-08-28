CoffeeScript.run = (cs) -> eval @compile cs, noWrap: on

self.print = (msg) ->
  out = document.getElementById 'out'
  out.insertBefore document.createTextNode(msg), out.firstChild
  msg
self.puts = (msg) -> print "#{msg}\n"; msg
self.$ = (id) -> document.getElementById id

code = $ 'code'
btns = $ 'btns'
for key of CoffeeScript when key isnt 'VERSION'
  btn = document.createElement 'button'
  k = btn.accessKey = key.charAt 0
  btn.id = key
  btn.onclick = -> puts CoffeeScript[@id] code.value
  btn.appendChild document.createTextNode k.toUpperCase() + key.slice 1
  btns.appendChild btn
$('run').click()
