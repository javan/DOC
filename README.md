#### `DOC`, a DOM traversal and manipulation utility for modern browsers. Work in progress.

---

`DOC(selector)` returns a `<doc-elements>` that quacks like a `DOC` object and array of matched elements.

Example usage given the following HTML:
```html
<ul class="list-a">
  <li>Item one</li>
  <li>Item two</li>
</ul>
<ul class="list-b"></ul>
```

In a pseudo CoffeeScript console:
```coffee
>> doc = DOC("ul.list-a li")
=> <doc-elements></doc-elements>

>> doc.length
=> 2

>> doc[0]
=> <li>Item one</li>

>> doc[1]
=> <li>Item two</li>

>> element for element in doc
=> [<li>Item one</li>, <li>Item two</li>]

>> doc.addClass("fancy")
=> <doc-elements></doc-elements>

>> document.body
=> <ul class="list-a">
     <li class="fancy">Item one</li>
     <li class="fancy">Item two</li>
   </ul>
   <ul class="list-b"></ul>

>> document.querySelector("ul.list-b").appendChild(doc)
>> document.body
=> <ul class="list-a"></ul>
   <ul class="list-b">
     <li class="fancy">Item one</li>
     <li class="fancy">Item two</li>
   </ul>
```
