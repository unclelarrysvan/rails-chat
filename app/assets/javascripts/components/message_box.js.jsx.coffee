@MessageBox = React.createClass
  getInitialState: ->
    console.log this.props
    return {
      messages: []
      room_id: this.props.room_id
    }

  componentDidMount: ->
    @setupSubscription()
    @loadMessagesFromServer()


  loadMessagesFromServer: ->
    $.ajax(
      url: '/messages'
      dataType: 'json'
      data: room_id: this.props.room_id
      success: (messages) =>
        @setState({messages: messages})
        console.log messages
      error: (xhr, status, err) =>
        console.error('/messages', status, err.toString())
    )

  handleMessageSubmit: (message) ->
    #App.room.speak message
    message.room_id = this.props.room_id
    $.ajax(
      url: '/messages'
      dataType: 'json'
      type: "POST"
      data: message: message
      success: (message) =>
        console.log message
      error: (xhr, status, err) =>
        console.error('/messages', status, err.toString())
        alert("Please sign in to chat")
    )

  render: ->
    `<ul className="messageBox list-group">
      <h2>Messages</h2>
      <MessageList messages={this.state.messages}/>
      <MessageForm onMessageSubmit={this.handleMessageSubmit}/>
    </ul>`

  updateMessageList: (message) ->
    @setState({messages: @state.messages.concat([message])})

  setupSubscription: ->
    App.room = App.cable.subscriptions.create "RoomChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
    
      disconnected: ->
        # Called when the subscription has been terminated by the server
    
      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        data.message.username = data.username
        @updateMessageList(data.message)
      
      updateMessageList: @updateMessageList
    
      #speak: (message) ->
      #  @perform 'speak', message: message
