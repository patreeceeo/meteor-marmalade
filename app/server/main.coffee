process.env.MAIL_URL="smtp://patrickcandoit%40gmail.com:qikndrhsbhnpkjoi@smtp.gmail.com:465/"

Meteor.methods
  sendEmail: (from, subject, text) ->
    check [from, subject, text], [String]

    @unblock()

    Email.send
      to: 'patrickcandoit@gmail.com'
      from: from
      subject: subject
      text: text
      replyTo: from
        
