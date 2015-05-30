assert = chai.assert

describe 'hand', ->
  deck = null
  dealerHand = null
  userHand = null
  card = null

  beforeEach ->
    deck = new Deck()
    userHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()
    card = new Card
      rank: 9
      suit: 1


  describe 'dealer hand', ->

    it 'should have two cards', ->
      assert.strictEqual dealerHand.length, 2

    it 'should have the first card flipped', ->
      assert.strictEqual dealerHand.first().get('revealed'), false

    it 'should sum the value of the cards in the hand', ->
      score = dealerHand.minScore()
      dealerHand.add(card)
      assert.strictEqual dealerHand.minScore() - score, card.get('value')


  describe 'player hand', ->

    it 'should have two cards', ->
      assert.strictEqual userHand.length, 2

    it 'should sum the value of the cards in the hand', ->
      score = userHand.minScore()
      userHand.add(card)
      assert.strictEqual userHand.minScore() - score, card.get('value')

    xit "should automatically bust if hand value is over 21", ->
      score = userHand.minScore()
      spy = sinon.spy(userHand.busted)
      userHand.add(card)
      console.log(userHand.minScore())
      assert.strictEqual spy.callCount, 1

    xit "should automatically call blackjack if hand value is 21", ->
      score = userHand.minScore()
      spy = sinon.spy(userHand.busted)
      userHand.add(card)
      console.log(userHand.minScore())
      assert.strictEqual spy.callCount, 1
      # return bus if score > 21
      # return bust if card.get('value') > 21


# should call 'blackjack!' if hand value is 21
