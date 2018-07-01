defmodule Gultalis.Action do
  use Slack

  def hear("hi", text, message, slack) do
    spawn(Gultalis.Action.Hi, :hear, [text, message, slack])
  end

  def hear("echo", text, message, slack) do
    spawn(Gultalis.Action.Echo, :hear, [text, message, slack])
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
    spawn(Gultalis.Action.Spreadsheet, :hear, [text, message, slack])
  end

  def hear(_, _, _, _) do
  end
end
