class window.ScoreBoardView extends Backbone.View
  el: '<div>'

  initialize: ->
    @model.on('change', @render, @)

  template: _.template '
  <div class="purse">Purse: <%= purse %></div>
  <div class="bet">Bet: <%= bet %></div>'

  render: ->
    @$el.html @template(@model.attributes)



