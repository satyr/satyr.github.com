$ = (id) -> document.getElementById id
append = (lmn, txt) -> lmn.appendChild document.createTextNode txt
echoer = (fn) -> (it) -> fn it; it

self.print =
  echoer (msg) ->
    pout.insertBefore document.createTextNode(msg), pout.firstChild
self.say = self.puts =
  echoer (msg) -> print msg + '\n'
self.p =
  echoer (it) -> say JSON.stringify it, null, 2

code = $ 'code'
btns = $ 'btns'
pout = $ 'pout'

for key of CoffeeScript when key not in ['VERSION', 'run', 'load']
  btn = document.createElement 'button'
  k = btn.accessKey = key.charAt 0
  btn.id = key
  btn.onfocus = -> code.focus()
  btn.onclick = ->
    {value} = code
    location.hash = encodeURI value
    puts CoffeeScript[@id] value, noWrap: on
  append btn, k.toUpperCase() + key[1..]
  btns.appendChild btn

eva1 = $ 'eval'
append eva1, ' (Ctrl + Enter)'
code.onkeydown = (ev) ->
  ev ||= event
  if ev.ctrlKey && ev.keyCode is 13
    eva1.click()
    false
setTimeout ->
  if c = location.hash[1..]
    code.value = try decodeURIComponent c catch _ then c
  eva1.click()
