class window.ScoreBoard extends Backbone.Model
	initialize: ->
		@on 'change', @checkForBankrupt, @


	defaults:
    	'purse': 100000
    	'bet': 20000

    checkForBankrupt: ->
    	if (@get 'purse') <= 0
    		@trigger('outOfMoney', @)

   	resetPurse: ->
   		@set 'purse', 100000

   	scoreResults: (won) ->
   		if won
   			@set 'purse', (@get 'purse') + (@get 'bet')
   		else
   			@set 'purse', (@get 'purse') - (@get 'bet')

   	double: ->
   		@set 'bet', @get('bet')*2