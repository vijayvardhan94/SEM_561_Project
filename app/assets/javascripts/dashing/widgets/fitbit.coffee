class Dashing.Fitbit extends Dashing.Widget

  ready: ->
    @visible = true
    @animate = true
    @determineView()

  onData: (data) ->
    
    #console.log("whatsupp")
    @currentView(@index).fadeOut() if @index
    clearInterval @interval if @interval

    if data.error
      @error = data.error
    else
      @animate = data.animate
      @error   = null
      @index   = 0

    @determineView() if @visible

  determineView: ->
    if @error
      @dataView().hide()
      @errorView().show()
    else
      @errorView().hide()
      @dataView().show()

      @determineViewType()

      if @animate
        #@firstView().fadeIn @animationLength()
        @transformMeters()
        @startAnimation()
      else
        @calculateBarWidth()
      
      @hideCurrentView()
      #console.log("@animate: " + @animate)
      #console.log("@get('viewtype'): " + @get('viewtype'))
      @currentView(@get('viewtype')).fadeIn @animationLength()

  determineViewType: ->
    if @animate
      @dataView().removeClass("list").addClass "animate"
    else
      @dataView().removeClass("animate").addClass "list"

  transformMeters: ->
    $(@node).find(".meter").each (index, element) =>
      meter = $(element)
      meter.attr "data-bgcolor", meter.css("background-color")
      meter.attr "data-fgcolor", meter.css("color")
      meter.attr "data-width", "125"
      meter.attr "data-height", "120"
      meter.attr "data-thickness", ".3"
      meter.attr "data-angleArc", "250"
      meter.attr "data-angleOffset", "-125"
      meter.attr "data-displayInput", "false"
      meter.attr "data-readOnly", "true"
      meter.knob()

      meter.val(meter.attr("value")).trigger "change"

  calculateBarWidth: ->
    $(@node).find(".bar").each (index, element) =>
      bar = $(element)
      bar.width (bar.width() / 100) * bar.attr("data-bar-width")

  startAnimation: ->
    #@interval = setInterval @animateView, 6000

  animateView: =>
    #@hideCurrentView() and @showNextView()

  hideCurrentView: ->
    @currentView(@index).fadeOut 10

  showNextView: ->
    #@findNextIndex()
    @index = 0 #Miguel: test code
    @currentView(@index).fadeIn @animationLength()

  findNextIndex: ->
    @index = (@index + 1)
    @index = 0 if @index > @lastIndex()

  lastIndex: ->
    @views().length - 1

  firstView: ->
    $(@views()[0])

  currentView: (index) ->
    $(@views()[index])

  views: ->
    $(@node).find(".views li")

  dataView: ->
    $(@node).find("#data")

  errorView: ->
    $(@node).find("#error")

  animationLength: ->
    1000
