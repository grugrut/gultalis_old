defmodule Gultalis.Action.React2Pocket do
  def addPocket(message, slack, item) do
    IO.puts(message |> extractOriginalUrl)

    HTTPoison.post!(
      "https://getpocket.com/v3/add",
      {:form,
       [
         url: message |> extractOriginalUrl,
         consumer_key: System.get_env("POCKET_CONSUMER_KEY"),
         access_token: System.get_env("POCKET_ACCESS_TOKEN")
       ]}
    )

    Slack.Web.Reactions.add("+1", %{token: slack.token, channel: item.channel, timestamp: item.ts})
  end

  defp extractOriginalUrl(message) do
    message
    |> Map.get("messages")
    |> hd
    |> Map.get("attachments")
    |> hd
    |> Map.get("original_url")
  end
end
