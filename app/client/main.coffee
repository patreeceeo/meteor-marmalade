Meteor.startup ->
  Router.addRoute '/', 'homeTemplate'
  Router.addRoute '/portfolio', 'portfolioTemplate'
  Router.addRoute '/philosophy', 'philosophyTemplate'
  Router.addRoute '/contact', 'contactTemplate'
  Router.addRoute '/contact/thanks', 'contactThanksTemplate'
  # Router.addRoute '/specs', 'specsTemplate'
  $(document).ready ->
    Router.attachEventListeners()

