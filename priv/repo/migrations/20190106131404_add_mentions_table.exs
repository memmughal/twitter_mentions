defmodule TwitterMentions.Repo.Migrations.AddMentionsTable do
  use Ecto.Migration

  def change do
	create table(:mentions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :author_name, :string
      add :text, :string
      add :tweet_creation_date, :utc_datetime
      add :number_of_retweets, :integer

      timestamps()
    end
  end
end
