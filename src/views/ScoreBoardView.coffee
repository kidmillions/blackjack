class window.ScoreBoardView extends Backbone.View
  el: '<div>'

  events:
  	'click #makeBet': 'makeBet'


  initialize: ->
    @model.on('change', @render, @)

  template: _.template '
  <span class="purse">Purse: <%= purse %></span>
  <span class="bet">Current Bet: <%= bet %></span>
  <input name="bet" type="text" placeholder="make a new bet" />
  <div id="makeBet">Place Your Bet</div>'


  render: ->
    @$el.html @template(@model.attributes)

  makeBet: ->
  	@model.set('bet', parseInt @$el.find('input').val() )
  	@$el.find('input').hide()
  	@$el.find('#makeBet').hide()




