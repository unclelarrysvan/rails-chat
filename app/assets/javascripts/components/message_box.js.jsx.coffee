@MessageBox = React.createClass
  getInitialState: ->
    return { messages: [] }

  componentDidMount: ->
    @setupSubscription()
    @loadMessagesFromServer()

  loadMessagesFromServer: ->
    $.ajax(
      url: '/messages'
      dataType: 'json'
      success: (messages) =>
        @setState({messages: messages})
      error: (xhr, status, err) =>
        console.error('/messages', status, err.toString())
    )

  handleMessageSubmit: (message) ->
    messages = @state.messages
    newMessages = messages.concat([message])
    @setState({messages: newMessages})
    App.room.speak message

  render: ->
    `<ul className="messageBox list-group">
      <h2>Messages</h2>
      <MessageList messages={this.state.messages}/>
      <MessageForm onMessageSubmit={this.handleMessageSubmit}/>
    </ul>`

  updateMessageList: (message) ->
    @loadMessagesFromServer()

  setupSubscription: ->
    App.room = App.cable.subscriptions.create "RoomChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
    
      disconnected: ->
        # Called when the subscription has been terminated by the server
    
      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        @updateMessageList(data.message)
      
      updateMessageList: @updateMessageList
    
      speak: (message) ->
        @perform 'speak', message: message
