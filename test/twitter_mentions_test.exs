defmodule TwitterMentionsTest do
  use ExUnit.Case

  alias TwitterMentions.Repo
  alias TwitterMentions.Schemas.Mentions

  describe "fetch with no results" do
    setup do
      Application.put_env(:twitter_mentions, :screen_name, "@no_results")
    end

    test "should add nothing to the database when no tweets are returned" do
      assert TwitterMentions.fetch() == {:error, :no_tweets_found}
      assert Repo.get_by(Mentions, mention_screen_name: "@no_results") == nil
    end
  end

  describe "fetch with results" do
    setup do
      Application.put_env(:twitter_mentions, :screen_name, "@test_name")
      TwitterMentions.fetch()

      :ok
    end

    test "should add results to the database when some tweets are returned" do
      mention_record = Repo.get_by(Mentions, mention_screen_name: "@test_name")
      assert %Mentions{mention_screen_name: "@test_name"} = mention_record
    end
  end

  describe "fetch same results twice when tweets are returned" do
    setup do
      Application.put_env(:twitter_mentions, :screen_name, "@test_name")
      TwitterMentions.fetch()
      TwitterMentions.fetch()

      :ok
    end

    test "should not add results twice to the database" do
      mention_record = Repo.get_by(Mentions, mention_screen_name: "@test_name")
      assert %Mentions{mention_screen_name: "@test_name"} = mention_record
    end
  end

  describe "unable to fetch results on reaching rate limit" do
    setup do
      Application.put_env(:twitter_mentions, :screen_name, "@rate_limit")
    end

    test "should return rate limit error" do
      assert TwitterMentions.fetch() == {:error, :rate_limit_exceeded}
    end
  end

  describe "unable to fetch results on invalid auth" do
    setup do
      Application.put_env(:twitter_mentions, :screen_name, "@invalid_auth")
    end

    test "should return twitter error" do
      assert TwitterMentions.fetch() == {:error, :twitter_error}
    end
  end
end
