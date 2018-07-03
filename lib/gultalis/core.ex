defmodule Gultalis.Slack do
  use Slack

  def handle_connect(slack, state) do
    IO.puts("Connected as #{slack.me.name}")
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    IO.puts(message.text)
    command = String.split(message.text, " ")
    Gultalis.Router.hear(hd(command), Enum.join(tl(command), " "), message, slack)
    {:ok, state}
  end

  def handle_event(_, _, state) do
    {:ok, state}
  end
end
