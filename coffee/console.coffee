$ = (id) -> document.getElementById id
silence = Date()

self.print = (msg, tag) ->
  return if msg is silence
  lmn = document.createElement tag || 'span'
  lmn.appendChild document.createTextNode msg + '\n'
  pout.insertBefore lmn, pout.firstChild
  silence
self.say = self.puts = (xs...) -> print xs.join '\n'
self.warn = (er) -> print er, 'em'
self.p = (xs...) -> say (JSON.stringify x, null, 2 for x in xs).join '\n'

code = $ 'code'
ctrl = $ 'ctrl'
pout = $ 'pout'
btns = {}
poem = code.value
kick = ->
  code.focus()
  {value} = code
  location.hash = @id.charAt() + ':' + encodeURI value if value isnt poem
  try r = CoffeeScript[@id] value, noWrap: on
  catch e
    warn e
    throw e
  (if @id is 'tokens' then p else puts) r

for key of CoffeeScript when key not in ['VERSION', 'run', 'load']
  btn = document.createElement 'button'
  btn.id = key
  btn.onclick = kick
  k = key.charAt()
  K = btn.accessKey = k.toUpperCase()
  btn.innerHTML = K + key[1..]
  btns[key] = btns[k] = ctrl.appendChild btn

for k, b of {C: eva1 = btns.eval, S: cmpl = btns.compile}
  b.innerHTML += " <small><code>\\#{k}-RET</code></small>"
document.onkeydown = (ev) ->
  return if (ev ||= event).keyCode isnt 13 || ev.altKey || ev.metaKey
  return unless b = (ev.ctrlKey && eva1) || (ev.shiftKey && cmpl)
  b.click()
  off
setTimeout ->
  if cf = location.hash[1..]
    try cf = decodeURIComponent cf catch _
    {$1: op, rightContext: cf} = RegExp if /^([a-v]+):/.test cf
    code.value = cf
  (if op then btns[op.toLowerCase()] else eva1).click()
