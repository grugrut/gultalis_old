defmodule Gultalis.Action do
  use Slack

  def hear("Hi", _, message, slack) do
    IO.puts("Hi")
    send_message("Hello to you too!", message.channel, slack)
  end

  def hear("echo", text, message, slack) do
    IO.puts("echo")
    send_message(text, message.channel, slack)
  end

  def hear("天気", _, message, slack) do
    IO.puts("天気")
    body = HTTPoison.get!("https://tenki.jp/forecast/3/16/4410/13105/").body

    body
    |> Floki.find("section.today-weather > div.weather-wrap.clearfix > div.weather-icon > p")
    |> Floki.text()
    |> send_message(message.channel, slack)

    body
    |> Floki.find("section.today-weather > div.weather-wrap.clearfix > div.date-value-wrap > dl")
    |> Floki.text()
    |> send_message(message.channel, slack)

    send_message("https://tenki.jp/forecast/3/16/4410/13105/", message.channel, slack)
  end

  def hear("ネタ", text, message, slack) do
    connection = GoogleApi.Sheets.V4.Connection.new(System.get_env("GOOGLE_OAUTH_TOKEN"))

    {:ok, _} =
      GoogleApi.Sheets.V4.Api.Spreadsheets.sheets_spreadsheets_values_append(
        connection,
        System.get_env("GOOGLE_MATERIAL_SHEET_ID"),
        "A1",
        [
          {:valueInputOption, "RAW"},
          {:body, %GoogleApi.Sheets.V4.Model.ValueRange{values: [[text]]}}
        ]
      )

    send_message(text <> "を登録しました", message.channel, slack)
  end

  def hear(_, _, _, _) do
  end
end
