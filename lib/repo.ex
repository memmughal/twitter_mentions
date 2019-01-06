defmodule TwitterMentions.Repo do
  use Ecto.Repo, otp_app: :twitter_mentions, adapter: Ecto.Adapters.Postgres
end
