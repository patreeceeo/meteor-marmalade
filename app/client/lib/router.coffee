##########################
## Router
##########################
 
window.Router =
  getURI: -> _.compact window.location.pathname.split("/")
  routes: []
  addRoute: (route, template) ->
    segments = _.compact route.split("/")

    placeholders = _.reduce segments, ((currentArr, piece, index) ->
      if piece.substr(0, 1) is ":"
        currentArr.push index
        segments[index] = piece.substr(1)
      currentArr
    ), []

    @routes.push
      segments: segments
      template: template
      placeholderIndexes: placeholders
  getMatchingRoute: ->
    for route in @routes
      data = {}
      uri = @getURI()

      if route.segments.length is uri.length
        match = _.every route.segments, ((seg, i) ->
          if _.contains route.placeholderIndexes, i
            data[seg] = uri[i]
            true
          else
            seg is uri[i]
        ), this

        if match 
          return {
            data: data
            template: route.template
          }
    # no matches (add 404 or default template maybe?)
    false
  go: (href) ->
    if window.history?.pushState?
      window.history.pushState null, null, href
      @run()
    else
      window.location.href = href
  attachEventListeners: ->
    atags = document.querySelectorAll('a[href]')
    document.addEventListener 'click', ((event) =>
      href = event.target.getAttribute 'href'
      if href?
        @go href
        event.preventDefault()
        false
    ), false

    window.addEventListener 'popstate', =>
      @run()
    @run()
  run: ->
    route = @getMatchingRoute()
    if route
      fragment = Meteor.render ->
        if Template[route.template]?
          Template[route.template](route.data)

      document.body.innerHTML = ''
      document.body.appendChild fragment
    else
      # 404

