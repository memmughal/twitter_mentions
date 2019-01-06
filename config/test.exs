use Mix.Config

config :twitter_mentions, TwitterMentions.Repo, pool: Ecto.Adapters.SQL.Sandbox

config :twitter_mentions, twitter_client: TwitterMentions.TwitterClient.Mock
