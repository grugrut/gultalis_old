defmodule Gultalis.Action.Hi do
  use Slack

  def hear(_, message, slack) do
    IO.puts("Hi")
    send_message("Hello to you too!", message.channel, slack)
  end
end
