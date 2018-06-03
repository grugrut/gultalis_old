defmodule Gultalis.Slack do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    IO.puts message.text
    if message.text == "Hi" do
      send_message("Hello to you too!", message.channel, slack)
    end
    {:ok, state}
  end

  def handle_event(_, _, state) do
    {:ok, state}
  end
end

