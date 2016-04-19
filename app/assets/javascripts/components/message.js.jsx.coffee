class @Message extends React.Component
  @propTypes =
    content: React.PropTypes.node

  render: ->
    `<div>{this.props.content}</div>`
