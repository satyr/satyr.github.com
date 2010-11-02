self.Coco = CoffeeScript
self.print = (msg, tag) ->
  return if msg is silence
  if print.last is print.last = msg
    ctrl.setAttribute 'data-x', -~ctrl.getAttribute 'data-x'
  else
    ctrl.setAttribute 'data-x', 1
    lmn = document.createElement tag || 'span'
    lmn.appendChild document.createTextNode msg + '\n'
    pout.insertBefore lmn, pout.firstChild
  silence
print.last = silence = Date()

self.clear = -> pout.innerHTML = ''
self.say = self.puts = (xs...) -> print xs.join '\n'
self.warn = (er) -> print "#{er}", 'em'
self.p = -> say (JSON.stringify x, null, 1 for x in arguments).join '\n'

$ = (id) -> document.getElementById id
code = $ 'code'
ctrl = $ 'ctrl'
pout = $ 'pout'
btns = {}
poem = '''
Coco.TREE






### radical yet practical
'''
kick = ->
  code.focus()
  {value} = code
  location.hash = @id.charAt() + ':' + encodeURI value if value isnt poem
  try r = Coco[@id] value, bare: true
  catch e then warn e; throw e
  switch @accessKey
  case 't'
    r = (token[0] for token in r).join(' ').replace /\n/g, '\\n'
  case 'n'
    r = r.expressions.join('').slice 1
  puts r

for Key in ['Tokens', 'Nodes', 'Compile', 'Eval']
  btn = document.createElement 'button'
  btn.id = key = Key.toLowerCase()
  btn.onclick = kick
  btn.innerHTML = Key
  btns[key] = btns[btn.accessKey = key.charAt 0] = ctrl.appendChild btn

for k, b of {C: eva1 = btns.eval, S: cmpl = btns.compile}
  b.innerHTML += " <small><kbd>\\#{k}-RET"
document.onkeydown = (ev) ->
  return if (ev ||= event).keyCode isnt 13 || ev.altKey || ev.metaKey
  return unless b = (ev.ctrlKey && eva1) || (ev.shiftKey && cmpl)
  b.click()
  false
setTimeout ->
  code.value = if cf = location.hash.slice 1
    try cf = decodeURIComponent cf
    {$1: op, rightContext: cf} = RegExp if /^([a-v]+):/.test cf
    cf
  else
    poem
  (if op then btns[op.toLowerCase()] else eva1).click()

self.onfocus = -> code.focus()

Coco.VERSION += '*'
Coco.TREE = 'cc38669561501df9ea2dad8a51d6811ab44ac305'
