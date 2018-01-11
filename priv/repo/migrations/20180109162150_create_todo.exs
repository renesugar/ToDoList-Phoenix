defmodule Test.Repo.Migrations.CreateToDo do
    use Ecto.Migration
  
    def change do
      create table(:tasks) do
        add :description, :string
        add :isFinished, :boolean

        timestamps()
      end
    end
  end
  