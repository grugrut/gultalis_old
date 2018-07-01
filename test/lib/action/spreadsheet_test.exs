defmodule Gultalis.Action.SpreadsheetTest do
  use ExUnit.Case
  doctest Gultalis.Action.Spreadsheet

  test "valid oauth token" do
    assert HTTPoison.get!(
             "https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=" <>
               Gultalis.Action.Spreadsheet.getAccessToken()
           ).status_code == 404
  end
end
