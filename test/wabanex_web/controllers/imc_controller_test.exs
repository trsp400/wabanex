defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "should return the IMC info if params are valid", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Luan" => 21.36686914318855,
          "Thamires" => 24.221453287197235,
          "Thiago" => 24.343809494085704
        }
      }

      assert expected_response == response
    end

    test "should not return the IMC info if params are invalid", %{conn: conn} do
      params = %{"filename" => "invalid_file.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error while trying to open the file"}

      assert expected_response == response
    end
  end
end
