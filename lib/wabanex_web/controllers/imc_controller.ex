defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  alias Wabanex.IMC

  def index(connection, params) do
    params
    |> IMC.read_file()
    |> handle_response(connection)
  end

  defp handle_response({:ok, result}, connection), do: render_response(connection, result, :ok)

  defp handle_response({:error, result}, connection),
    do: render_response(connection, result, :bad_request)

  defp render_response(connection, result, status) do
    connection
    |> put_status(status)
    |> json(%{result: result})
  end
end
