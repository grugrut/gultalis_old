defmodule Gultalis.Action.Spreadsheet do
  use Slack

  defp getAccessToken do
    body =
      HTTPoison.post!(
        "https://www.googleapis.com/oauth2/v4/token",
        {:form,
         [
           refresh_token: System.get_env("GOOGLE_REFRESH_TOKEN"),
           client_id: System.get_env("GOOGLE_CLIENT_ID"),
           client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
           grant_type: "refresh_token"
         ]}
      ).body

    Poison.decode!(body)["access_token"]
  end

  defp getConnection do
    GoogleApi.Sheets.V4.Connection.new(getAccessToken())
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

    send_message(text <> "を登録しました", message.channel, slack)
  end
end

# curl --data "refresh_token=$GOOGLE_REFRESH_TOKEN" --data "client_id=$GOOGLE_CLIENT_ID" --data "client_secret=$GOOGLE_CLIENT_SECRET" --data "grant_type=refresh_token" https://www.googleapis.com/oauth2/v4/token