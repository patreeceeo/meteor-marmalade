Meteor.startup ->
  Router.addRoute '/', 'homeTemplate'
  Router.addRoute '/portfolio', 'portfolioTemplate'
  Router.run()
