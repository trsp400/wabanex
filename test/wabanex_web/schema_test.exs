defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "Users Queries" do
    test "shoudl return a user when a valid id is given", %{conn: conn} do
      params = %{name: "Thiago", email: "roblesthiago38@gmail.com", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            id
            name
            email
          }
        }
      """

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "roblesthiago38@gmail.com",
            "id" => user_id,
            "name" => "Thiago"
          }
        }
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "should create the user when all params are valid", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input:{name: "Thiago Robles", email:"roblesthiago38@gmail.com", password: "123456"}) {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "createUser" => %{
            "email" => "roblesthiago38@gmail.com",
            "name" => "Thiago Robles"
          }
        }
      }

      assert response == expected_response
    end
  end
end
