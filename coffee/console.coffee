$ = (id) -> document.getElementById id
append = (lmn, txt) -> lmn.appendChild document.createTextNode txt
echoer = (fn) -> (it) -> fn it; it

self.print = echoer (msg) ->
  pout.insertBefore document.createTextNode(msg), pout.firstChild
self.say = self.puts = echoer (msg) -> print msg + '\n'
self.p = echoer (it) -> say JSON.stringify it, null, 2

code = $ 'code'
ctrl = $ 'ctrl'
pout = $ 'pout'
btns = {}

for key of CoffeeScript when key not in ['VERSION', 'run', 'load']
  btn = document.createElement 'button'
  btn.id = key
  btn.onfocus = -> code.focus()
  btn.onclick = ->
    {value} = code
    location.hash = @id.charAt() + ':' + encodeURI value
    (if @id is 'tokens' then p else puts) CoffeeScript[@id] value, noWrap: on
  k = btn.accessKey = key.charAt()
  K = k.toUpperCase()
  append btn, K + key[1..]
  btns[key] = btns[k] = ctrl.appendChild btn

eva1 = btns.eval
append eva1, ' (Ctrl + Enter)'
code.onkeydown = (ev) ->
  ev ||= event
  if ev.ctrlKey && ev.keyCode is 13
    eva1.click()
    false
setTimeout ->
  if cf = location.hash[1..]
    try cf = decodeURIComponent cf catch _
    {$1: op, rightContext: cf} = RegExp if /^([a-v]+):/.test cf
    code.value = cf
  (if op then btns[op.toLowerCase()] else eva1).click()
