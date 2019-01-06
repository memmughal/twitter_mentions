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
    try do
      name = Application.get_env(:twitter_mentions, :screen_name) || "@chris_mccord"

      with [%ExTwitter.Model.Tweet{} = tweet] = ExTwitter.search(name, count: 1) do
        %{
          mention_screen_name: name,
          author_name: tweet.retweeted_status.user.screen_name,
          text: tweet.text,
          tweet_creation_date: tweet.retweeted_status.created_at,
          number_of_retweets: tweet.retweet_count
        }
      end
    rescue
      ExTwitter.RateLimitExceededError ->
        Logger.error("Rate limit exceeded, please try again later")
    end
  end
end
