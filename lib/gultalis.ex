defmodule Gultalis do
  use Application

  def start(_type, _args) do
    token = System.get_env("API_KEY")
    {:ok, gultalis} = Slack.Bot.start_link(Gultalis.Slack, [], token)
  end
end
