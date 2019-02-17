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

  def handle_event(message = %{type: "reaction_added", reaction: "heart"}, slack, state) do
    IO.puts(message.item.ts)

    Slack.Web.Channels.history(
      message.item.channel,
      %{
        token: slack.token,
        latest: Float.to_string(String.to_float(message.item.ts) + 0.000001),
        oldest: Float.to_string(String.to_float(message.item.ts) - 0.000001),
        count: 1
      }
    )
    |> Gultalis.Action.React2Pocket.addPocket(slack, message.item)

    {:ok, state}
  end

  def handle_event(_, _, state) do
    {:ok, state}
  end
end
