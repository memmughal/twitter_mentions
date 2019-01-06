defmodule TwitterMentions.Schemas.Mentions do
  use Ecto.Schema

  import Ecto.Changeset

  @required_field [
    :mention_screen_name,
    :author_name,
    :text,
    :tweet_creation_date,
    :number_of_retweets
  ]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "mentions" do
    field(:mention_screen_name, :string)
    field(:author_name, :string)
    field(:text, :string)
    field(:tweet_creation_date, :string)
    field(:number_of_retweets, :integer)

    timestamps()
  end

  def changeset(%{} = params) do
    %__MODULE__{}
    |> cast(params, @required_field)
    |> validate_required(@required_field)
  end

  def insert(
        %{
          mention_screen_name: _,
          author_name: _,
          text: _,
          tweet_creation_date: _,
          number_of_retweets: _
        } = params
      ) do
    params
    |> changeset()
    |> TwitterMentions.Repo.insert()
  end
end
