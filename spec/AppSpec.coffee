assert = chai.assert

describe 'app', ->
  app = null
  userHand = null
  card9 = null
  card8 = null
  card4 = null
  card10 = null
  spy = sinon.spy Hand.prototype, 'getNewCards'
  dealerSpy = sinon.spy Hand.prototype, 'dealerPlay'
  winGame = null
  loseGame = null

  beforeEach ->
    app = new App();
    userHand = app.get('playerHand')
    card9 = new Card
      rank: 9
      suit: 1
    card8 = new Card
      rank: 8
      suit: 1
    card4 = new Card
      rank: 4
      suit: 3
    card10 = new Card
      rank: 10
      suit: 2
    winGame = ->
      userHand.reset()
      userHand.add(card9)
      userHand.add(card8)
      userHand.add(card4)
    loseGame = ->
      userHand.reset()
      userHand.add(card9)
      userHand.add(card8)
      userHand.add(card10)

  describe 'Winning', ->

    it "should reset the user's hand", ->
      winGame();
      assert.strictEqual spy.called, true

    it "should increase the ScoreBoard by the bet amount", ->
      currentScore = app.get('scoreBoard').get('purse')
      bet = app.get('scoreBoard').get('bet')
      winGame()
      assert.strictEqual currentScore+bet, app.get('scoreBoard').get('purse')



  describe 'Losing', ->
    it "should reset the user's hand", ->
      loseGame()
      assert.strictEqual spy.called, true

    it "should decrease the ScoreBoard by the bet amount", ->
      currentScore = app.get('scoreBoard').get('purse')
      bet = app.get('scoreBoard').get('bet')
      loseGame()
      assert.strictEqual currentScore-bet, app.get('scoreBoard').get('purse')


  describe 'Dealer', ->
    it "should invoke the dealer to take its turn when the player stands", ->
      userHand.stand()
      assert.strictEqual dealerSpy.called, true



# Compares hand values and designates winner
# Triggers when Player Busts
# Triggers when Player loses to dealer
# Triggers when Player Wins

