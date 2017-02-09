class MainComponent extends CommonComponent
  @register 'MainComponent'

  onCreated: ->
    @html = new ReactiveField ''
    @configuration = new ReactiveField ''

    @output = new ReactiveField ''
    @error = new ReactiveField null

    @autorun (computation) =>
      try
        @output new Sanitize(eval("(#{@configuration() or '{}'})") or {}).sanitizeHTML @html()
        @error null
      catch error
        @output null
        @error error

  onRendered: ->
    @html @$('#html').val()
    @configuration @$('#configuration').val()

  events: ->
    super.concat
      'submit form': (event) ->
        event.preventDefault()
  
      'change #html, keyup #html': (event) ->
        event.preventDefault()
  
        @html $(event.target).val()
  
      'change #configuration, keyup #configuration': (event) ->
        event.preventDefault()
  
        @configuration $(event.target).val()

      'click button': (event) ->
        event.preventDefault()

        @$('#rendered-output').html @output()
