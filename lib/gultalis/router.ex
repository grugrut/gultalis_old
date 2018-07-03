defmodule Gultalis.Router do
  use Slack

  def hear("hi", text, message, slack) do
    spawn(Gultalis.Action.Hi, :hear, [text, message, slack])
  end

  def hear("echo", text, message, slack) do
    spawn(Gultalis.Action.Echo, :hear, [text, message, slack])
  end

  def hear("天気", _, message, slack) do
    spawn(Gultalis.Action.Weather, :hear, [nil, message, slack])
  end

  def hear("ネタ", text, message, slack) do
    spawn(Gultalis.Action.Spreadsheet, :hear, [text, message, slack])
  end

  def hear(_, _, _, _) do
  end
end
