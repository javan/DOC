div = document.createElement("div")
div.classList.add("hello")
div.innerHTML = "Hello world"

module "DOC",
  beforeEach: ->
    document.body.appendChild(div)
  afterEach: ->
    document.body.removeChild(div)

test "find", ->
  equal DOC(".hello").length, 1
  equal DOC.find(".hello").length, 1
