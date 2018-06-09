defmodule Gultalis.Action do
  def hear("Hi", _, message, slack) do
    IO.puts("Hi")
    Slack.Sends.send_message("Hello to you too!", message.channel, slack)
  end

  def hear("echo", text, message, slack) do
    IO.puts("echo")
    Slack.Sends.send_message(text, message.channel, slack)
  end

  def hear(_, _, _, _) do
  end
end
