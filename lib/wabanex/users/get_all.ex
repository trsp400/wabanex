defmodule Wabanex.Users.Get_All do
  alias Wabanex.{Repo, User}

  def call() do
    Repo.all(User)
    # |> Enum.map(fn element -> element end)
    # |> Enum.into(%{})
  end
end
