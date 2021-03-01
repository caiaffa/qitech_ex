defmodule QITech.Middleware.Auth do
  @moduledoc false

  @behaviour Tesla.Middleware

  alias QITech.JWT.Token

  def call(env, next, _opts) do
    env
    |> prepare_request()
    |> Tesla.run(next)
    |> prepare_response()
  end

  defp prepare_request(%{body: body} = env) when is_map(body) do
    {:ok, encoded_body, md5_hash} = Token.encode_body_and_hash(body)

    header_opts = default_header_opts(env, content_md5: md5_hash)

    env
    |> Tesla.put_body(%{"encoded_body" => encoded_body})
    |> Tesla.put_headers(Token.create_header(header_opts))
  end

  defp prepare_request(env) do
    env
    |> Tesla.put_headers(Token.create_header(default_header_opts(env)))
  end

  defp prepare_response({:ok, env}) do
    case decodable?(env) do
      true ->
        %{"encoded_body" => encoded_body} = env.body
        {:ok, body} = Token.decode(encoded_body)
        {:ok, %{env | body: body}}

      false ->
        {:ok, env}
    end
  end

  defp prepare_response({:error, reason}), do: {:error, reason}

  defp default_header_opts(env, opts \\ []) do
    header_opts = [
      http_verb: env.method,
      url: env.url,
      content_md5: nil,
      content_type: "application/json"
    ]

    Keyword.merge(header_opts, opts) |> Enum.into(%{})
  end

  defp decodable?(%{body: nil}), do: false
  defp decodable?(%{body: body}) when is_binary(body), do: true
  defp decodable?(%{body: %Tesla.Multipart{}}), do: false
  defp decodable?(_), do: true
end
