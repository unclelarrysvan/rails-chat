class @MessageForm extends React.Component
  handleSubmit: (e) =>
    message = @refs.message.value.trim()
    @props.onMessageSubmit({content: message})
    @refs.message.value = ''
    e.preventDefault()
    e.stopPropagation()
    return false

  render: ->
    `<form className="messageForm" onSubmit={this.handleSubmit}>
      <input
        type='text'
        placeholder='Say something...'
        ref='message'
        className='form-control'
      />

      <input type='submit' value='Post' className='btn btn-primary'/>
    </form>`
