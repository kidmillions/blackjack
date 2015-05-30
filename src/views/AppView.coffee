class window.AppView extends Backbone.View
  template: _.template '<div class="group"><div class="button-container"><div class="hit-button">Hit</div> <div class="stand-button">Stand</div>
    <% if (playerHand.isSplit()) { %><div class="split-button">Split</div><% } %></div>
    <div class="score-board"></div></div>
    <div class="group"><div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div></div>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .split-button': -> @model.split()

  initialize: ->
    @model.on('change', @render, @)
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes 
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.score-board').html new ScoreBoardView(model: @model.get 'scoreBoard').render()
