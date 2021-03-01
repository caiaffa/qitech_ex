defmodule QITech.Middleware.SimplifyResponseTest do
  use ExUnit.Case

  describe "Simplified Response" do
    defmodule Client do
      @moduledoc false
      use Tesla

      plug(QITech.Middleware.SimplifyResponse, true)

      adapter(fn env ->
        {status, headers, body} =
          case env.url do
            "/without-body" ->
              {200, [{"content-type", "application/json"}], nil}

            "/with-body" ->
              {200, [{"content-type", "application/json"}], env.body}

            "/with-client-error" ->
              {400, [{"content-type", "application/json"}], nil}
          end

        {:ok, %{env | status: status, headers: headers, body: body}}
      end)
    end

    test "simple return without body" do
      {:ok, response} = Client.get("/without-body")
      assert response.body == nil
      assert response.status == 200
    end

    test "simple return with body" do
      {:ok, response} = Client.post("/with-body", %{"ping" => "pong"})
      assert response.body == %{"ping" => "pong"}
    end

    test "simple return with client error" do
      {:error, response} = Client.get("/with-client-error")
      assert response == %{body: nil, status: 400}
    end
  end

  describe "Error Response" do
    defmodule ErrorClient do
      @moduledoc false
      use Tesla

      plug(QITech.Middleware.SimplifyResponse, true)

      adapter(fn env ->
        {reason} =
          case env.url do
            "/with-timeout" ->
              {:timeout}
          end

        {:error, reason}
      end)
    end

    test "simple return with timeout" do
      {:error, response} = ErrorClient.get("/with-timeout")
      assert response == :timeout
    end
  end

  describe "Complete Response" do
    defmodule CompleteClient do
      @moduledoc false
      use Tesla

      plug(QITech.Middleware.SimplifyResponse, false)

      adapter(fn env ->
        {status, headers, body} =
          case env.url do
            "/with-body" ->
              {200, [{"content-type", "application/json"}], env.body}

            "/with-client-error" ->
              {400, [{"content-type", "application/json"}], nil}
          end

        {:ok, %{env | status: status, headers: headers, body: body}}
      end)
    end

    test "simple return with body" do
      {:ok, response} = CompleteClient.post("/with-body", %{"ping" => "pong"})
      assert response.body == %{"ping" => "pong"}
    end
  end
end
