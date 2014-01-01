##########################
## Router
##########################
 
window.Router =
  uri: _.compact window.location.pathname.split("/")
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

      if route.segments.length is this.uri.length
        match = _.every route.segments, ((seg, i) ->
          if _.contains route.placeholderIndexes, i
            data[seg] = @uri[i]
            true
          else
            seg is @uri[i]
        ), this

        if match 
          return {
            data: data
            template: route.template
          }
    # no matches (add 404 or default template maybe?)
    false
  run: ->
    route = @getMatchingRoute()
    if route
      fragment = Meteor.render ->
        if Template[route.template]?
          Template[route.template](route.data)

      document.body.appendChild fragment
    else
      # 404
