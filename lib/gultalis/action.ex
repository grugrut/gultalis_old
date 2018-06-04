defmodule Gultalis.Action do
  def hear("Hi", message, slack) do
    Slack.Sends.send_message("Hello to you too!", message.channel, slack)
  end

  def hear(_, _, _) do
  end
end
