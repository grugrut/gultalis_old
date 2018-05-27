defmodule Gultalis do
  use Application

  def start(_type, _args) do
    token = Application.get_env(:gultalis, :api_key)
    {:ok, gultalis} = Slack.Bot.start_link(Gultalis.Slack, [], token)
  end
end
