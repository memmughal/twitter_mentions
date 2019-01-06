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

  def fetch do
    try do
      get_twitter_authentication_data()

      mentions =
        get_screen_name()
        |> ExTwitter.search(count: 2)
        |> map_mentions()

      TwitterMentions.Repo.insert_all(TwitterMentions.Schemas.Mentions, mentions)
    rescue
      ExTwitter.RateLimitExceededError ->
        Logger.error("Rate limit exceeded, please try again later")
    end
  end

  defp map_mentions([]), do: {:error, :no_tweets_found}
  defp map_mentions(mentions) when is_list(mentions), do: Enum.map(mentions, &format_mention/1)

  defp format_mention(%ExTwitter.Model.Tweet{} = tweet) do
    %{
      mention_screen_name: get_screen_name(),
      author_name: tweet.retweeted_status.user.screen_name,
      text: tweet.text,
      tweet_creation_date: tweet.retweeted_status.created_at,
      number_of_retweets: tweet.retweet_count,
      inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    }
  end

  defp get_screen_name, do: Application.fetch_env!(:twitter_mentions, :screen_name)

  def get_twitter_authentication_data do
    :extwitter
    |> Application.fetch_env!(:oauth)
    |> Keyword.get(:consumer_key)
    |> raise_if_nil(:consumer_key)

    :extwitter
    |> Application.fetch_env!(:oauth)
    |> Keyword.get(:consumer_secret)
    |> raise_if_nil(:consumer_secret)

    :extwitter
    |> Application.fetch_env!(:oauth)
    |> Keyword.get(:access_token)
    |> raise_if_nil(:access_token)

    :extwitter
    |> Application.fetch_env!(:oauth)
    |> Keyword.get(:access_token_secret)
    |> raise_if_nil(:access_token_secret)
  end

  defp raise_if_nil(nil, key), do: raise("expects #{key} to be configured for extwitter")
  defp raise_if_nil(value, _key), do: value
end
