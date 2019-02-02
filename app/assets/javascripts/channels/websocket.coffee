App.web_notifications = App.cable.subscriptions.create "WebsocketChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(JSON.stringify(data))
    switch data['type']
     when 'notification' then $.notify { message: data['message'] },
                                 type: 'info'
                                 newest_on_top: true
                                 offset: 20
                                 spacing: 10
                                 allow_dismiss: true
                                 template:     '<div data-notify=\"container\" class=\"col-xs-11 col-sm-2 alert alert-{0}\" role=\"alert\">' +
                                               '<button type=\"button\" aria-hidden=\"true\" class=\"close\" data-notify=\"dismiss\">×</button>' +
                                               '<span data-notify=\"icon\"></span> ' +
                                               '<span data-notify=\"title\">{1}</span> ' +
                                               '<span data-notify=\"message\">{2}</span>' +
                                               '<div class=\"progress\" data-notify=\"progressbar\">' +
                                               '<div class=\"progress-bar progress-bar-{0}\" role=\"progressbar\" aria-valuenow=\"0\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 0%;\"></div>' +
                                               '</div>' +
                                               '<a href=\"{3}\" target=\"{4}\" data-notify=\"url\"></a>' +
                                               '</div>'

     when 'update_screen' then $("#status-columns").html(data['data'])
     else console.log("Don't know how to deal with:" + JSON.stringify(data));
