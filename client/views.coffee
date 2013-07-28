class ExampleView extends Backbone.View
  element: 'body'
  tagName: 'div'
  className: 'example'

  events: 'click body': $.noop

  initialize: ->
