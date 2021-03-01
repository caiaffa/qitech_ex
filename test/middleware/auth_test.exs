defmodule QITech.Middleware.AuthTest do
  use ExUnit.Case

  describe "Auth middleware" do
    defmodule Client do
      @moduledoc false
      use Tesla

      plug(QITech.Middleware.Auth)

      adapter(fn env ->
        {status, headers, body} =
          case env.url do
            "/without-body" ->
              {200, [{"content-type", "application/json"}], nil}

            "/with-body" ->
              {200, [{"content-type", "application/json"}], env.body}
          end

        {:ok, %{env | status: status, headers: headers, body: body}}
      end)
    end

    test "auth with body" do
      {:ok, response} = Client.post("/with-body", %{"ping" => "pong"})
      assert response.body == %{"ping" => "pong"}
    end

    test "auth without body" do
      {:ok, %{status: status, body: body}} = Client.get("/without-body")
      assert body == nil
      assert status == 200
    end
  end
end
