defmodule TwitterMentions.TwitterClient.Mock do
  @moduledoc """
  Module to mock twitter api methods.
  """

  def get_mentions!(screen_name: screen_name), do: get_results(screen_name)

  defp get_results("@no_results"), do: {:ok, []}

  defp get_results("@test_name") do
    {:ok,
     [
       %ExTwitter.Model.Tweet{
         retweeted_status: %{
           created_at: "Tue Jan 01 14:14:03 +0000 2019",
           retweet_count: 10,
           text:
             "Bestsellers for December:\n\n* Test-Driven React by @trevorburnham\n* Programming Phoenix 1.4 by @chris_mccord,… https://t.co/MQZ9hQjhv5",
           user: %{
             screen_name: "@test_name"
           }
         },
         text:
           "RT @pragprog: Bestsellers for December:\n\n* Test-Driven React by @trevorburnham\n* Programming Phoenix 1.4 by @chris_mccord, @BruceTate, and…",
         id_str: "1080368816238907397"
       }
     ]}
  end

  defp get_results("@rate_limit"), do: {:error, :rate_limit_exceeded}
  defp get_results("@invalid_auth"), do: {:error, :twitter_error}
end
