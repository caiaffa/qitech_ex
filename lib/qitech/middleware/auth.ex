defmodule QITech.Middleware.Auth do
  @moduledoc """
  QITech authentication and encode/decode middleware

  [Documentation](https://qitech.com.br/documentacao?file=221)

  ## Example
  ```
  defmodule MyClient do
    use Tesla
    plug QITech.Middleware.Auth
  end
  ```
  ## Options
  """

  @behaviour Tesla.Middleware

  alias QITech.JWT.Token

  def call(env, next, _opts) do
    env
    |> prepare_request()
    |> Tesla.run(next)
    |> prepare_response()
  end

  defp prepare_request(%{body: body} = env) when is_map(body) do
    {:ok, encoded_body, _} = Token.encode(body)

    env
    |> Tesla.put_body(%{"encoded_body" => encoded_body})
    |> Tesla.put_headers(create_header(env, Token.md5(encoded_body)))
  end

  defp prepare_request(env) do
    env
    |> Tesla.put_headers(create_header(env))
  end

  defp prepare_response({:ok, env}) do
    %{"encoded_body" => encoded_body} = env.body

    {:ok, body} = Token.decode(encoded_body)
    {:ok, %{env | body: body}}
  end

  defp prepare_response({:error, reason}), do: {:error, reason}

  defp create_header(env, content_md5 \\ nil) do
    http_verb = env.method |> to_string() |> String.upcase()
    date = Timex.now() |> Timex.format!("%a, %d %b %Y %H:%M:%S GMT", :strftime)
    relative_url = URI.parse(env.url) |> relative_url()

    {:ok, authorization, _} =
      Token.string_to_sign(http_verb, content_md5, "application/json", date, relative_url)
      |> Token.signature_json()
      |> Token.encode()

    authorization
    |> Token.headers()
  end

  defp relative_url(%URI{path: path, query: query}) when is_nil(query), do: path
  defp relative_url(%URI{path: path, query: query}), do: "#{path}?#{query}"
end
