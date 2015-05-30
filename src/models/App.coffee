# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'scoreBoard', scoreBoard = new ScoreBoard()

    # @listenTo @get('playerHand'), 'busted', @loseGame
    @get('playerHand').on 'busted', @loseGame, @
    @get('playerHand').on 'blackjack', @winGame, @


  resetDeck: ->
    # @set 'deck', deck = new Deck()
    @get('playerHand').getNewCards()
    @set 'dealerHand', @get('deck').dealDealer()
    console.log(@get('playerHand'))


  winGame: ->
  # Notification that player got blackjack
    console.log('you win!')
    # Update Score
    bet = @get('scoreBoard').get('bet')
    purse = @get('scoreBoard').get('purse')
    @get('scoreBoard').set 'purse', purse + bet
    # Game to be reset
    @resetDeck()



  loseGame: ->
    # Notification that player busted
    # Update ScoreBoard
    bet = @get('scoreBoard').get('bet')
    purse = @get('scoreBoard').get('purse')
    @get('scoreBoard').set 'purse', purse - bet
    # Game to be reset
    @resetDeck()




