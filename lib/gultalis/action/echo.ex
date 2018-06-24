defmodule Gultalis.Action.Echo do
  use Slack

  def hear(text, message, slack) do
    IO.puts("echo")
    send_message(text, message.channel, slack)
  end
end
