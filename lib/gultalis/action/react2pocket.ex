defmodule Gultalis.Action.React2Pocket do
  def addPocket(message, slack) do
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
