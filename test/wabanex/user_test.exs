defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "should  return a changeset when params are valid" do
      params = %{name: "Thiago", email: "roblesthiago38@gmail.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{name: "Thiago", email: "roblesthiago38@gmail.com", password: "123456"},
               errors: []
             } = response
    end

    test "should not return a changeset when params are not valid" do
      params = %{name: "a", email: "roblesthiago38@gmail.com"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
