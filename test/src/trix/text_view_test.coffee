#= require trix/views/text_view
#= require fixtures

module "Trix.TextView"


test "#createElementsForText", ->
  text = fixture("plain")
  elements = getElementsForText(text)
  equal elements.length, 1, "one element for plain string"

  el = elements[0]
  equal el.tagName.toLowerCase(), "span", "container element is a span"
  equal el.trixPosition, 0, "container element has a trixPosition"
  equal el.childNodes.length, 1, "container element has one child node"

  node = el.firstChild
  equal node.nodeType, Node.TEXT_NODE, "child node is a text node"
  equal node.data, text.toString(), "child node contains text string"
  equal node.trixPosition, 0, "child node has a trixPosition property"
  equal node.trixLength, text.getLength(), "child node has a trixLength property"

  text = Trix.Text.textForStringWithAttributes(fixture("plain").toString() + "\n")
  elements = getElementsForText(text)
  equal elements.length, 2, "two elements for string ending with a newline"
  equal elements[0].lastChild.tagName.toLowerCase(), "br", "container element's last child is a BR"
  equal elements[1].tagName.toLowerCase(), "br", "last element is an extra BR"

# Helpers

getElementsForText = (text) ->
  element = document.createElement("div")
  textView = new Trix.TextView element, text
  textView.createElementsForText()
