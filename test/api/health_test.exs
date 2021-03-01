defmodule QITech.API.HealthTest do
  @doc false

  use ExUnit.Case

  alias QITech.API.Health
  alias Tesla.Mock
  @base_url "https://api-auth.sandbox.qitech.app"

  setup_all do
    Mock.mock_global(fn
      %{method: :post, url: @base_url <> "/test"} ->
        %Tesla.Env{
          status: 201,
          body: %{
            "encoded_body" =>
              "eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9.eyJwaW5nIjoicG9uZyJ9.AYtG_Sj5o_Hao6cBvGVjExeQSACllaD3CPGRxlGRPYvjcTwx-LpVwe_ayfCezos0lbH5Ri1EfayawhCAs9aotf57ANtXcPSa0E_b1pHNqcH8agD7cRWgLb9DeyEEfx9E9larABlaVoi4DunR7P_yf-1CSPEZ6xLjOIkVXSQeZYRPF_M5"
          }
        }
    end)

    :ok
  end

  test "when test is valid, returns test info" do
    assert {:ok, %{body: %{"ping" => "pong"}, status: 201}} = Health.ping()
  end
end
