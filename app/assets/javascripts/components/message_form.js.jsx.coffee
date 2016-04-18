class @MessageForm extends React.Component
  handleSubmit: (e) =>
    message = this.refs.message.value.trim()
    this.props.onMessageSubmit({content: message})
    this.refs.message.value = ''
    e.preventDefault()
    e.stopPropagation()
    return false

  render: ->
    `<form className="messageForm" onSubmit={this.handleSubmit}>
      <input
        type='text'
        placeholder='Say something...'
        ref='message'
      />

      <input type='submit' value='Post' id='messageForm'/>
    </form>`
