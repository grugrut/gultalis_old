defmodule Gultalis.Action.Weather do
  use Slack

  def hear(_, message, slack) do
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
end
