defmodule Gultalis do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    api_key =
      case System.get_env("API_KEY") do
        nil -> Application.get_env(:Gultalis, :api_key)
        s -> s
      end

    children = [
      worker(Slack.Bot, [Gultalis.Slack, [], api_key])
    ]

    opts = [strategy: :one_for_one, name: Gultalis.Supervisor]
    {:ok, _pid} = Supervisor.start_link(children, opts)
  end
end
