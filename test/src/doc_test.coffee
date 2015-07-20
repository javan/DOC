html = """
  <div id="fixture">
    <ul class="fruits" id="fruit-list">
      <li>Apple</li>
      <li>Orange</li>
    <ul>
  </div>
"""

module "DOC",
  beforeEach: ->
    document.body.insertAdjacentHTML("beforeend", html)
  afterEach: ->
    fixture = document.getElementById("fixture")
    fixture.parentNode.removeChild(fixture)

test "#all", ->
  equal DOC("ul.fruits li").length, 2
  equal DOC.all("ul.fruits li").length, 2

test "#find", ->
  equal DOC("ul.fruits").find("li").length, 1
  equal DOC.find("ul.fruits li").length, 1

test "#find nothing", ->
  equal DOC("ul.fruits").find("li.not-here"), null
  equal DOC.find("li.not-here"), null
