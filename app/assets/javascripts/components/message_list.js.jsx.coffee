class @MessageList extends React.Component
  render: ->
    messageNodes = this.props.messages.map (message, index) ->
      `<Message content={message.content} key={index} />`

    return (
      `<div className="messageList">
        { messageNodes }
      </div>`
    )
