# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
    initialize: ->
        @set 'deck', deck = new Deck()
        @set 'playerHand', deck.dealPlayer()
        @set 'dealerHand', deck.dealDealer()
        @set 'scoreBoard', scoreBoard = new ScoreBoard()

        @get('dealerHand').on 'all', @dealerEvents, @
        @get('playerHand').on 'all', @playerEvents, @
        @get('deck').on 'shuffle', @get('deck').makeNewDeck, @get('deck')
        @get('scoreBoard').on 'outOfMoney', @loseLife, @


    playerEvents: (event, hand) ->
        switch event
            when 'busted' then @loseGame()
            when 'blackjack' then @winGame()
            when 'stand' then @get('dealerHand').dealerPlay()

    dealerEvents: (event, hand) ->
        switch event
            when 'busted' then @winGame()
            when 'blackjack' then @loseGame()
            when 'stand' then @compareScores()

    resetHands: ->
        # @set 'deck', deck = new Deck()
        @get('playerHand').getNewCards()
        @get('dealerHand').getNewCards()


    winGame: ->
      # Notification that player got blackjack
        # Update Score
        alert 'You won!'
        bet = @get('scoreBoard').get('bet')
        purse = @get('scoreBoard').get('purse')
        @get('scoreBoard').set 'purse', purse + bet
        # Game to be reset
        @get('deck').checkLength()
        @resetHands()


    loseGame: ->
        # Notification that player busted
        # Update ScoreBoard
        alert 'You Lost!'
        bet = @get('scoreBoard').get('bet')
        purse = @get('scoreBoard').get('purse')
        @get('scoreBoard').set 'purse', purse - bet
        # Game to be reset
        @get('deck').checkLength()
        @resetHands()

    pushGame: ->
        alert 'Push!'
        @get('deck').checkLength()
        @resetHands()

    loseLife: ->
        alert 'you are seriously out of money. don\'t do that again.'
        @get('scoreBoard').set 'purse', 100000

    compareScores: ->
        userHand = @get('playerHand')
        dealerHandScore = @get('dealerHand').minScore()
        maxUserScore = Math.max(userHand.scores[0], userHand.scores[1])
        userScore = if maxUserScore < 21 then maxUserScore else userHand.scores[0]
        if userScore > dealerHandScore then @winGame() else if userScore == dealerHandScore then @pushGame() else @loseGame()

    split: ->
        @set 'playerHand2', new Hand [@get('playhand2').pop()], @








