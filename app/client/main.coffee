Meteor.startup ->
  Router.addRoute '/', 'homeTemplate'
  Router.addRoute '/portfolio', 'portfolioTemplate'
  $(document).ready ->
    Router.attachEventListeners()
