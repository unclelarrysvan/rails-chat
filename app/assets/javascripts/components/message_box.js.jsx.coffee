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

  render: ->
    `<ul className="messageBox list-group">
      <h2>Messages</h2>
      <MessageList messages={this.state.messages}/>
    </ul>`
