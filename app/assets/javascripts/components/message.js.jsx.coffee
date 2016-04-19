class @Message extends React.Component
  @propTypes =
    content: React.PropTypes.node
    username: React.PropTypes.node

  render: ->
    `<div>{this.props.username}: {this.props.content}</div>`
