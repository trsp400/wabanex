defmodule WabanexWeb.Resolvers.Training do
  def create(%{input: params}, __context), do: Wabanex.Trainings.Create.call(params)
end
