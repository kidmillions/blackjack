assert = chai.assert

describe 'hand', ->
  deck = null
  dealerHand = null
  userHand = null
  card9 = null
  card8 = null
  card10 = null
  card4 = null
  flip = null
  hitSpy = sinon.spy Hand.prototype, 'hit'


  beforeEach ->
    deck = new Deck()
    userHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()
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


  describe 'dealer hand', ->

    it 'should have two cards', ->
      assert.strictEqual dealerHand.length, 2

    it 'should have the first card flipped when initalized', ->
      assert.strictEqual dealerHand.first().get('revealed'), false

    it 'should not call hit if the value of cards are 17 or more', ->
      standSpy = sinon.spy Hand.prototype, 'stand'
      dealerHand.reset()
      card8.set('revealed', false)
      dealerHand.add(card8)
      dealerHand.add(card10)
      dealerHand.dealerPlay()
      assert.strictEqual hitSpy.called, false
      assert.strictEqual standSpy.called, true


    it 'should reveal its card when the dealer start its turn', ->
      dealerHand.dealerPlay()
      flip = dealerHand.first().get('revealed')
      assert.strictEqual flip, true


    it 'should hit if the value of cards are less than 17', ->
      dealerHand.reset()
      dealerHand.add(card8)
      dealerHand.add(card4)
      dealerHand.dealerPlay()
      assert.strictEqual hitSpy.called, true







  describe 'player hand', ->

    it 'should have two cards', ->
      assert.strictEqual userHand.length, 2

    it 'should sum the value of the cards in the hand', ->
      score = userHand.minScore()
      userHand.add(card9)
      assert.strictEqual userHand.minScore() - score, card9.get('value')

    it "should automatically bust if hand value is over 21", ->
      score = userHand.minScore()
      spy = sinon.spy Hand.prototype, 'busted'
      userHand.add(card9)
      userHand.add(card8)
      userHand.add(card10)
      console.log(userHand.minScore())
      assert.strictEqual spy.called, true

    it "should automatically call blackjack if hand value is 21", ->
      score = userHand.minScore()
      spy = sinon.spy Hand.prototype, 'blackjack'
      userHand.reset()
      userHand.add(card9)
      userHand.add(card8)
      userHand.add(card4)
      console.log(userHand.minScore())
      assert.strictEqual spy.called, true


