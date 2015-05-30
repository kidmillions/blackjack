class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @makeNewDeck()


  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  checkLength: ->
    if @length <= 15 then @trigger('shuffle')

  makeNewDeck: ->
    @reset()
    console.log('new deck made')
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
