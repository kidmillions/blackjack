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
      assert.strictEqual deck.length, 48
      lastVal = deck.last().get 'value'
      hand.hit()
      assert.strictEqual lastVal, hand.last().get 'value'
      assert.strictEqual deck.length, 47

  describe "deck constructor", ->

    it "should create a card collection", ->
      collection = new Deck()
      assert.strictEqual collection.length, 52