Meteor.startup ->
  Router.addRoute '/', 'homeTemplate'
  Router.addRoute '/portfolio', 'portfolioTemplate'
  Router.addRoute '/philosophy', 'philosophyTemplate'
  # Router.addRoute '/specs', 'specsTemplate'
  $(document).ready ->
    Router.attachEventListeners()
