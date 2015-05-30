class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @blackjack() if Math.max(@scores()[0], @scores()[1]) == 21
    @busted() if @minScore() > 21

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  busted: ->
    console.log(@minScore())
    @trigger('busted', @)
    console.log('busted')
    # if score is higher than 21
    #   trigger an event on collection, 'busted'

  blackjack: ->
    console.log(@minScore())
    @trigger('blackjack', @)
    console.log('blackjack')

  getNewCards: ->
    @reset()
    #deal new cards when current deck
    @hit()
    @hit()
