class window.ScoreBoardView extends Backbone.View
  el: '<div>'

  events:
  	'click #makeBet': 'makeBet'


  initialize: ->
    @model.on('change', @render, @)

  template: _.template '
  <div class="purse">Purse: <%= purse %></div>
  <div class="bet">Bet: <%= bet %></div>
  <div class="bets"><input name="bet" type="text" />
  <div id="makeBet">Place Your Bet</div>	'


  render: ->
    @$el.html @template(@model.attributes)

  makeBet: ->
  	@model.set('bet', parseInt @$el.find('input').val() )
  	@$el.find('input').hide()
  	@$el.find('#makeBet').hide()




