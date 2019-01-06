defmodule TwitterMentions.TwitterClient.Twitter do
  @moduledoc """
  Module to call twitter api methods.
  """
  require Logger

  def get_mentions!(screen_name: screen_name) do
    try do
      check_twitter_auth_credentials()

      {:ok, ExTwitter.search(screen_name)}
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

  defp check_twitter_auth_credentials() do
    keys = [:consumer_key, :consumer_secret, :access_token, :access_token_secret]
    Enum.each(keys, &get_twitter_config_value!/1)

    :ok
  end

  defp get_twitter_config_value!(key) do
    :extwitter
    |> Application.fetch_env!(:oauth)
    |> Keyword.fetch!(key)
    |> raise_if_invalid!(key)
  end

  defp raise_if_invalid!(nil, key), do: raise("expects #{key} to be configured for extwitter")
  defp raise_if_invalid!("", key), do: raise("expects #{key} to be configured for extwitter")
  defp raise_if_invalid!(value, _key), do: value
end
