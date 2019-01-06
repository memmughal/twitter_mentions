defmodule TwitterMentions do
  @moduledoc """
  Provides helper methods to fetch and save twitter mentions data.
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

  @doc """
    Fetches twitter mention data and saves it in the `TwitterMentions.Schemas.Mentions`.
    # Requires
    - `screen_name`: to be set in the application configuration

    ## Examples

      iex> TwitterMentions.fetch()
      {n, nil}  `where n is the number of new records fetched`
  """
  def fetch do
    try do
      check_twitter_auth_credentials()

      mentions =
        get_screen_name()
        |> ExTwitter.search(count: 2)
        |> map_mentions()

      TwitterMentions.Repo.insert_all(TwitterMentions.Schemas.Mentions, mentions,
        on_conflict: :nothing
      )
    rescue
      ExTwitter.RateLimitExceededError ->
        Logger.error("Rate limit exceeded, please try again later")
        {:error, :rate_limit_exceeded}

      ExTwitter.Error ->
        Logger.error("Please check twitter auth credentials in the config")
        {:error, :twitter_error}

      error ->
        Logger.error("Some error occurred #{inspect(error)}")
        error
    end
  end

  defp map_mentions([]), do: {:error, :no_tweets_found}
  defp map_mentions(mentions) when is_list(mentions), do: Enum.map(mentions, &format_mention/1)

  defp format_mention(%ExTwitter.Model.Tweet{} = tweet) do
    %{
      twitter_id: tweet.id_str,
      mention_screen_name: get_screen_name(),
      author_name: tweet.retweeted_status.user.screen_name,
      text: tweet.retweeted_status.text,
      tweet_creation_date: tweet.retweeted_status.created_at,
      number_of_retweets: tweet.retweet_count,
      inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    }
  end

  defp get_screen_name, do: Application.fetch_env!(:twitter_mentions, :screen_name)

  defp check_twitter_auth_credentials() do
    keys = [:consumer_key, :consumer_secret, :access_token, :access_token_secret]
    Enum.each(keys, &get_twitter_config_value!/1)

    :ok
  end

  defp get_twitter_config_value!(key) do
    :extwitter
    |> Application.fetch_env!(:oauth)
    |> Keyword.get(key)
    |> raise_if_invalid!(key)
  end

  defp raise_if_invalid!(nil, key), do: raise("expects #{key} to be configured for extwitter")
  defp raise_if_invalid!("", key), do: raise("expects #{key} to be configured for extwitter")
  defp raise_if_invalid!(value, _key), do: value

  def get_all, do: TwitterMentions.Repo.all(Mentions)
end
