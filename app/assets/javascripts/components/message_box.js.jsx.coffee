@MessageBox = React.createClass
  getInitialState: ->
    return { messages: [] }

  componentDidMount: ->
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
