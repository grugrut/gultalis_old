defmodule Gultalis.Action do
  def hear("Hi", _, message, slack) do
    IO.puts("Hi")
    Slack.Sends.send_message("Hello to you too!", message.channel, slack)
  end

  def hear("echo", text, message, slack) do
    IO.puts("echo")
    Slack.Sends.send_message(text, message.channel, slack)
  end

  def hear("天気", _, message, slack) do
    IO.puts("天気")
    body = HTTPoison.get!("https://tenki.jp/forecast/3/16/4410/13105/").body

    body
    |> Floki.find("section.today-weather > div.weather-wrap.clearfix > div.weather-icon > p")
    |> Floki.text()
    |> Slack.Sends.send_message(message.channel, slack)

    body
    |> Floki.find("section.today-weather > div.weather-wrap.clearfix > div.date-value-wrap > dl")
    |> Floki.text()
    |> Slack.Sends.send_message(message.channel, slack)

    Slack.Sends.send_message("https://tenki.jp/forecast/3/16/4410/13105/", message.channel, slack)
  end

  def hear(_, _, _, _) do
  end
end
