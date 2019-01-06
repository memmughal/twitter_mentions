defmodule TwitterMentions.Schemas.Mentions do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "mentions" do
    field(:mention_screen_name, :string)
    field(:author_name, :string)
    field(:text, :string)
    field(:tweet_creation_date, :string)
    field(:number_of_retweets, :integer)

    timestamps()
  end
end
