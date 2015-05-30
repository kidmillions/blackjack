class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template
    if @model.get 'revealed'	
    	@$el.find('img').attr('src', "./img/cards/" + @model.get('rankName') + "-" + @model.get('suitName') + ".png") 
    else
    	@$el.find('img').attr('src', "./img/card-back.png") 

    @$el.addClass 'covered' unless @model.get 'revealed'

