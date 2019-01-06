defmodule TwitterMentions do
  @moduledoc """
  Documentation for TwitterMentions.
  """

  require Logger

  @doc """
  Hello world.

  ## Examples

      iex> TwitterMentions.hello()
      :world

  """
  def hello do
    :world
  end

  def get_mentions do
    with [%ExTwitter.Model.Tweet{} = tweet] = tweets <- ExTwitter.search("@josevalim", count: 1) do
      IO.inspect("author_name: #{tweet.retweeted_status.user.screen_name}")
      IO.inspect("text_1: #{inspect(tweet.retweeted_status.text)}")
      IO.inspect("text_2: #{inspect(tweet.text)}")
      IO.inspect("date: #{inspect(tweet.retweeted_status.created_at)}")
      IO.inspect("retweet_count: #{tweet.retweet_count}")

      Logger.info("done")

      tweets
    end
  end
end
