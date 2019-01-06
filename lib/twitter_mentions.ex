defmodule TwitterMentions do
  @moduledoc """
  Provides helper methods to fetch and save twitter mentions data.
  """

  require Logger

  alias TwitterMentions.Repo
  alias TwitterMentions.Schemas.Mentions

  @twitter_client Application.get_env(:twitter_mentions, :twitter_client)

  @doc """
    Fetches twitter mention data and saves it in the `TwitterMentions.Schemas.Mentions`.
    # Requires
    - `screen_name`: to be set in the application configuration

    ## Examples

      iex> TwitterMentions.fetch()
      {n, nil}  `where n is the number of new records fetched`

    ## Getting historic data

    standard public twitter api only provides data for the last 7 days, if historic
    data is required, premium/enyerprise account needs to be set up

    standard search api returns results with default limit of 15 and
    can be set to 100 with
                   ExTwitter.search(search_term, count: 100)

    search can be provided with options of date i.e. `until: 2018-12-31`
    it will respond with tweets before this date
  """
  def fetch do
    with {:ok, mentions} <- @twitter_client.get_mentions!(screen_name: get_screen_name()),
         {:ok, formatted_mentions} <- map_mentions(mentions) do
      Repo.insert_all(Mentions, formatted_mentions, on_conflict: :nothing)
    end
  end

  defp get_screen_name, do: Application.fetch_env!(:twitter_mentions, :screen_name)

  defp map_mentions([]), do: {:error, :no_tweets_found}

  defp map_mentions(mentions) when is_list(mentions),
    do: {:ok, Enum.map(mentions, &format_mention/1)}

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

  def get_all, do: TwitterMentions.Repo.all(Mentions)
end
