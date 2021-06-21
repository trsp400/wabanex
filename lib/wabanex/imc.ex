defmodule Wabanex.IMC do
  def read_file(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\n")
      |> Enum.map(fn element -> parse_line(element) end)
      |> Enum.into(%{})

    {:ok, data}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Error while trying to open the file"}
  end

  defp parse_line(element) do
    element
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
