elementMap = new WeakMap()

definition =
  elements:
    get: ->
      if elements = elementMap.get(this)
        elements
      else
        [document]

    set: (elements) ->
      elementMap.set(this, elements)
      @[index] = element for element, index in elements

  length:
    get: ->
      @elements.length

  attachedCallback: ->
    fragment = document.createDocumentFragment()
    fragment.appendChild(element) for element in @elements
    @parentNode.appendChild(fragment)
    @parentNode.removeChild(this)

  find: (selector) ->
    elements = []
    for element in @elements
      elements.push(element.querySelectorAll(selector)...)
    DOC(elements)

  first: ->
    DOC(@[0])

  last: ->
    DOC(@[@length - 1])

  on: (event, handler) ->
    for element in @elements
      element.addEventListener(event, handler)
    this

  off: (event, handler) ->
    for element in @elements
      element.removeEventListener(event, handler)
    this

  add: (attributes = {}) ->
    for element in @elements
      for key, value of attributes
        element.setAttribute(key, value)
    this

  remove: (attributes = {}) ->
    for element in @elements
      for key, value of attributes
        element.removeAttribute(key, value)
    this

  addClass: (name) ->
    for element in @elements
      element.classList.add(name)
    this

  removeClass: (name) ->
    for element in @elements
      element.classList.remove(name)
    this

for key in Object.getOwnPropertyNames(Array::) then do (key) ->
  if key isnt "constructor" and typeof Array::[key] is "function"
    definition[key] = ->
      Array::[key].apply(@elements, arguments)

for key, value of definition
  definition[key] = if typeof value is "function" then {value} else value

tagName = "doc-elements"
prototype = Object.create(HTMLElement.prototype, definition)
document.registerElement(tagName, {prototype})

@DOC = (selector) ->
  elements = switch
    when typeof selector is "string"
      [document.querySelectorAll(selector)...]
    when "length" of selector
      [selector...]
    else
      [selector]

  el = document.createElement(tagName)
  el.elements = elements
  el

Object.defineProperties(DOC, definition)
