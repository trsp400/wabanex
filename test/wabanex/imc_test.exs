defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  describe "calculate/1" do
    test "should return the data when file exists" do
      params = %{"filename" => "students.csv"}

      response = Wabanex.IMC.read_file(params)

      expected_response =
        {:ok,
         %{
           "Luan" => 21.36686914318855,
           "Thamires" => 24.221453287197235,
           "Thiago" => 24.343809494085704
         }}

      assert expected_response == response
    end

    test "should not return any data file does not exists" do
      params = %{"filename" => "nonexist.csv"}

      response = Wabanex.IMC.read_file(params)

      expected_response = {:error, "Error while trying to open the file"}

      assert expected_response == response
    end
  end
end
