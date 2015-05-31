# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
    initialize: ->
        @set 'deck', deck = new Deck()
        @set 'playerHand', deck.dealPlayer()
        @set 'dealerHand', deck.dealDealer()
        @set 'scoreBoard', scoreBoard = new ScoreBoard()
        @set 'playing', false
        @get('dealerHand').on 'all', @dealerEvents, @
        @get('playerHand').on 'all', @playerEvents, @
        @get('deck').on 'shuffle', @get('deck').makeNewDeck, @get('deck')
        @get('scoreBoard').on 'outOfMoney', @loseLife, @


    playerEvents: (event, hand) ->
        switch event
            when 'busted' then @loseGame()
            when 'blackjack' then @winGame()
            when 'stand' then @get('dealerHand').dealerPlay()
            when 'hit' then @set('playing', true)

    dealerEvents: (event, hand) ->
        switch event
            when 'busted' then @winGame()
            when 'blackjack' then @loseGame()
            when 'stand' then @compareScores()

    resetHands: ->
        @get('playerHand').getNewCards()
        @get('dealerHand').getNewCards()


    winGame: ->
        alert 'You won!'
        @get('scoreBoard').scoreResults(true)
        @get('deck').checkLength()
        @set('playing', false)
        @resetHands()


    loseGame: ->
        alert 'You Lost!'
        @get('scoreBoard').scoreResults(false)
        @get('deck').checkLength()
        @set('playing', false)
        @resetHands()

    pushGame: ->
        alert 'Push!'
        @get('deck').checkLength()
        @set('playing', false)
        @resetHands()

    loseLife: ->
        alert 'you are seriously out of money. don\'t do that again.'
        @get('scoreBoard').resetPurse()


        

    compareScores: ->
        userHand = @get('playerHand')
        dealerHandScore = @get('dealerHand').minScore()
        maxUserScore = Math.max(userHand.scores[0], userHand.scores[1])
        userScore = if maxUserScore < 21 then maxUserScore else userHand.scores[0]
        if userScore > dealerHandScore then @winGame() else if userScore == dealerHandScore then @pushGame() else @loseGame()


    doubleBet: ->
        @get('scoreBoard').double();
        @get('playerHand').hit()
        @get('playerHand').stand();


    split: ->
        @set 'playerHand2', new Hand [@get('playhand2').pop()], @
        # deal one new card to each hand
        # 
        # play on playerHand standing or busting
        # if also standing, compare top values
        # compare highest hand to dealers








