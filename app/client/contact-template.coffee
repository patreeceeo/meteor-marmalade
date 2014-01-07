_.extend Template.contactTemplate,
  rendered: ->
    $textarea = $('textarea')
    wh = $(window).innerHeight()
    offset  = $textarea.offset().top
    $textarea.height wh - offset - 100
  flash: ->
    Session.get 'flash'
  events:
    'click #send-button': _.throttle (->
      text = $('textarea').val()
      from = $('[name=from]').val()
      Session.set 'flash', "Sending..."
      Meteor.call 'sendEmail', from, 'Message from a Marmalade visitor', text, (error) ->
        if not error?
          Session.set 'flash', ''
          Router.go '/contact/thanks'
        else
          Session.set 'flash', "Something is broken: #{error.message}"
    ), 5000

      
