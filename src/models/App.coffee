# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
    initialize: ->
        @set 'deck', deck = new Deck()
        @set 'playerHand', deck.dealPlayer()
        @set 'dealerHand', deck.dealDealer()
        @set 'scoreBoard', scoreBoard = new ScoreBoard()

        # @listenTo @get('playerHand'), 'busted', @loseGame
        @get('dealerHand').on 'blackjack', @loseGame, @
        @get('dealerHand').on 'busted', @winGame, @
        @get('playerHand').on 'busted', @loseGame, @
        @get('playerHand').on 'blackjack', @winGame, @
        @get('playerHand').on 'stand', @get('dealerHand').dealerPlay, @get('dealerHand')
        @get('dealerHand').on 'stand', @compareScores, @
        @get('deck').on 'shuffle', @get('deck').makeNewDeck, @get('deck')


    resetDeck: ->
        # @set 'deck', deck = new Deck()
        @get('playerHand').getNewCards()
        @get('dealerHand').getNewCards()


    winGame: ->
      # Notification that player got blackjack
        # Update Score
        bet = @get('scoreBoard').get('bet')
        purse = @get('scoreBoard').get('purse')
        @get('scoreBoard').set 'purse', purse + bet
        # Game to be reset
        @get('deck').checkLength()
        @resetDeck()


    loseGame: ->
        # Notification that player busted
        # Update ScoreBoard
        bet = @get('scoreBoard').get('bet')
        purse = @get('scoreBoard').get('purse')
        @get('scoreBoard').set 'purse', purse - bet
        # Game to be reset
        @get('deck').checkLength()
        @resetDeck()

    pushGame: ->
        @get('deck').checkLength()
        @resetDeck()


    compareScores: ->
        userHand = @get('playerHand')
        dealerHandScore = @get('dealerHand').minScore()
        maxUserScore = Math.max(userHand.scores[0], userHand.scores[1])
        userScore = if maxUserScore < 21 then maxUserScore else userHand.scores[0]
        if userScore > dealerHandScore then @winGame() else if userScore == dealerHandScore then @pushGame() else @loseGame()










