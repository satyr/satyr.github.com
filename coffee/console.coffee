self.append = (lmn, txt) ->
  lmn.appendChild document.createTextNode txt
  lmn
self.print = (msg) ->
  out = document.getElementById 'out'
  out.insertBefore document.createTextNode(msg), out.firstChild
  msg
self.puts = (msg) -> print "#{msg}\n"; msg
self.$ = (id) -> document.getElementById id

code = $ 'code'
btns = $ 'btns'
for key of CoffeeScript when key not in ['VERSION', 'run', 'load']
  btn = document.createElement 'button'
  k = btn.accessKey = key.charAt 0
  btn.id = key
  btn.onclick = -> puts CoffeeScript[@id] code.value, noWrap: on
  btn.onfocus = -> code.focus()
  append btn, k.toUpperCase() + key.slice 1
  btns.appendChild btn

eva1 = $ 'eval'
append eva1, ' (Ctrl + Enter)'
code.onkeydown = (ev) ->
  ev ||= event
  if ev.ctrlKey && ev.keyCode is 13
    eva1.click()
    false

setTimeout -> eva1.click()
