assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealer = deck.dealDealer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

  describe "deck constructor", ->

    it "should create a card collection", ->
      collection = new Deck()
      assert.strictEqual collection.length, 52

    it "should trigger an event that the deck is out of cards", ->
      outOfCards = sinon.spy Deck.prototype, 'outOfCards'
      # deal a million times
      # when deckLength = 0
      # outOfCards triggered
      assert.strictEqual deck.length, 0
      assert.strictEqual outOfCards.called, true



        # should not reset deck until cards exhausted
