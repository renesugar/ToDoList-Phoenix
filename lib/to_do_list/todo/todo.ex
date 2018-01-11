defmodule ToDoList.ToDo do
    @moduledoc """
    The ToDo List context.
    """

    import Ecto.Query, warn: false
    alias ToDoList.Repo

    alias ToDoList.ToDo.Task

    @doc """
    Returns the list of tasks.

    ## Examples

            iex> list_tasks()
            [%Task{}, ...]

    """
    def list_tasks do
        Repo.all(Task)
    end

    @doc """
    Gets a single task.

    Raises `Ecto.NoResultsError` if the Task does not exist.

    ## Examples

            iex> get_task!(123)
            %Task{}

            iex> get_task!(456)
            ** (Ecto.NoResultsError)

    """
    def get_task!(id), do: Repo.get!(Task, id)

    @doc """
    Creates a task.

    ## Examples

            iex> create_task(%{fields: value})
            {:ok, %Task{}}

            iex> create_task(%{fields: bad_value})
            {:error, %Ecto.Changeset{}}

    """
    def create_task(attrs \\ %{}) do
        %Task{}
        |> Task.changeset(attrs)
        |> Repo.insert()
    end

    @doc """
    Updates a task.

    ## Examples
            
            iex> update_task(task, %{fields: new_value})
            {:ok, %Task{}}

            iex> update_task(task, %{fields: bad_value})
            {:error, %Ecto.Changeset{}}

    """
    def update_task(%Task{} = task, attrs) do
        task
        |> Task.changeset(attrs)
        |> Repo.update()
    end

    @doc """
    Deletes a task.

    ## Examples

            iex> delete_task(task)
            {:ok, %Task{}}

            iex> delete_task(task)
            {:error, %Ecto.Changeset}

    """
    def delete_task(%Task{} = task) do
        Repo.delete(task)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking task changes

    ## Examples

            iex> change_task(task)
            %Ecto.Changeset(source: %Task{})
    """
    def change_task(%Task{} = task) do
        Task.changeset(task, %{})
    end
end