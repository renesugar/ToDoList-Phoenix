defmodule ToDoListWeb.ToDoController do
    use ToDoListWeb, :controller

    alias ToDoList.ToDo
    alias ToDoList.ToDo.Task

    def index(conn, _params) do
        tasks = ToDo.list_tasks()
        render(conn, "index.html", tasks: tasks)
    end

    def new(conn, _params) do
        changeset = ToDo.change_task(%Task{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"task" => task_params}) do
        case ToDo.create_task(task_params) do
            {:ok, _task} ->
                conn
                |> put_flash(:info, "Task created successfully.")
                |> redirect(to: to_do_path(conn, :index))
            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end

    def edit(conn, %{"id" => id}) do
        task = ToDo.get_task!(id)
        changeset = ToDo.change_task(task)
        render(conn, "edit.html", task: task, changeset: changeset)
    end
    
    def update(conn, %{"id" => id, "task" => task_params}) do
        task = ToDo.get_task!(id)
    
        case ToDo.update_task(task, task_params) do
          {:ok, _task} ->
            conn
            |> put_flash(:info, "Task updated successfully.")
            |> redirect(to: to_do_path(conn, :index))
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", task: task, changeset: changeset)
        end
    end

    def check(conn, %{"id" => id}) do
        task = ToDo.get_task!(id);
        
        case ToDo.update_task(task, %{isFinished: !task.isFinished}) do
            {:ok, _task} ->
                conn
                |> put_flash(:info, "Task now check.")
                |> redirect(to: to_do_path(conn, :index))
            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "index.html", task: task, changeset: changeset)
        end
    end
    
    def delete(conn, %{"id" => id}) do
        task = ToDo.get_task!(id)
        {:ok, _task} = ToDo.delete_task(task)
    
        conn
        |> put_flash(:info, "Task deleted successfully.")
        |> redirect(to: to_do_path(conn, :index))
    end
end