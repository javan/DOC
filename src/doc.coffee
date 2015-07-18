elementMap = new WeakMap()

definition =
  elements:
    enumerable: true
    get: ->
      elementMap.get(this) ? []
    set: (elements) ->
      elementMap.set(this, elements)
      @[index] = element for element, index in elements

  length:
    enumerable: true
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

  first: (selector) ->
    element = @[0]
    element = element.querySelector(selector) if selector?
    DOC(element)

  last: (selector) ->
    if selector?
      @find(selector).last()
    else
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

  addData: (data = {}) ->
    for element in @elements
      for key, value of data
        element.dataset[key] = value
    this

  removeData: (keys...) ->
    for element in @elements
      for key in keys
        delete element.dataset[key]
    this

for key in Object.getOwnPropertyNames(Array::) then do (key) ->
  if key isnt "constructor" and typeof Array::[key] is "function"
    definition[key] = ->
      Array::[key].apply(@elements, arguments)

for key, value of definition
  if typeof value is "function"
    value = value: value, enumerable: true
  definition[key] = value

tagName = "doc-elements"
prototype = Object.create(HTMLElement.prototype, definition)
document.registerElement(tagName, {prototype})

@DOC = (selector) ->
  elements = switch
    when typeof selector is "string"
      document.querySelectorAll(selector)
    when Array.isArray(selector) or selector?.length?
      selector
    when selector instanceof HTMLElement or selector instanceof HTMLDocument
      [selector]
    when not selector?
      [document]
    else
      throw new Error "Don't know how to handle #{selector}"

  el = document.createElement(tagName)
  el.elements = elements
  el

DOC[key] = value for key, value of DOC(document)
