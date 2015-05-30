class window.ScoreBoard extends Backbone.Model
	initialize: ->
		@on 'change', @checkForBankrupt, @


	defaults:
    	'purse': 100000
    	'bet': 20000

    checkForBankrupt: ->
    	if (@get 'purse') <= 0
    		@trigger('outOfMoney', @)