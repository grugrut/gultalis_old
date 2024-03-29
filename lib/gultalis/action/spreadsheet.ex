defmodule Gultalis.Action.Spreadsheet do
  if Mix.env() == :test do
    @compile :export_all
    @compile :nowarn_export_all
  end

  use Slack

  defp getAccessToken do
    HTTPoison.post!(
      "https://www.googleapis.com/oauth2/v4/token",
      {:form,
       [
         refresh_token: System.get_env("GOOGLE_REFRESH_TOKEN"),
         client_id: System.get_env("GOOGLE_CLIENT_ID"),
         client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
         grant_type: "refresh_token"
       ]}
    )
    |> body
    |> Poison.decode!()
    |> access_token
  end

  defp body(%{status_code: 200, body: json_body}), do: json_body
  defp access_token(%{"access_token" => token}), do: token

  defp getConnection do
    getAccessToken()
    |> GoogleApi.Sheets.V4.Connection.new()
  end

  def hear("", message, slack) do
    GoogleApi.Sheets.V4.Api.Spreadsheets.sheets_spreadsheets_values_get(
      getConnection(),
      System.get_env("GOOGLE_MATERIAL_SHEET_ID"),
      "A1"
    )
    |> range_values
    |> Enum.at(0)
    |> Enum.random()
    |> send_message(message.channel, slack)
  end

  def hear(text, message, slack) do
    {:ok, _} =
      GoogleApi.Sheets.V4.Api.Spreadsheets.sheets_spreadsheets_values_append(
        getConnection(),
        System.get_env("GOOGLE_MATERIAL_SHEET_ID"),
        "A1",
        [
          {:valueInputOption, "RAW"},
          {:body, %GoogleApi.Sheets.V4.Model.ValueRange{values: [[text]]}}
        ]
      )

    (text <> "を登録しました")
    |> send_message(message.channel, slack)
  end

  defp range_values({:ok, range}), do: range.values
end
