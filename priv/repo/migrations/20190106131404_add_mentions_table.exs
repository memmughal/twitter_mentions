defmodule TwitterMentions.Repo.Migrations.AddMentionsTable do
  use Ecto.Migration

  def change do
    create table(:mentions, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:twitter_id, :string)
      add(:mention_screen_name, :string)
      add(:author_name, :string)
      add(:text, :string)
      add(:tweet_creation_date, :string)
      add(:number_of_retweets, :integer)

      timestamps()
    end

    create(unique_index(:mentions, [:twitter_id]))
  end
end
