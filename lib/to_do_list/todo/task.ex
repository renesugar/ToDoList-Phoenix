defmodule ToDoList.ToDo.Task do
    use Ecto.Schema
    import Ecto.Changeset
    alias ToDoList.ToDo.Task

    schema "tasks" do
        field :description, :string
        field :isFinished, :boolean, default: false

        timestamps()
    end

    @doc false
    def changeset(%Task{} = task, attrs) do
        task
        |> cast(attrs, [:description, :isFinished])
        |> validate_required([:description])
    end
end