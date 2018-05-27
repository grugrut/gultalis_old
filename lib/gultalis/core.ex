defmodule Gultalis.Slack do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    reply = "Received #{length(state)} messages so far"
    send_message(reply, message.channel, slack)
    {:ok, state ++ [message.text]}
  end

  def handle_message(message, _slack, state) do
    {:ok, state}
  end
end

