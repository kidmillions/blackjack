assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49


describe "deck constructor", ->

        it "should create a card collection", ->
          collection = new Deck()
          assert.strictEqual collection.length, 52

        it "should create a randomly generated deck", ->
          collection1 = new Deck()
          collection2 = new Deck()
          # Save for later




          # Cards should have value that coorelates to rank/type


          # should not reset deck until cards exhausted
