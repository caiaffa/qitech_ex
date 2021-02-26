defmodule QITech.JWT.Token do
  use Joken.Config

  alias Joken.Signer
  @algorithm "ES512"

  @impl true
  def token_config, do: %{}

  def encode(payload) when is_map(payload) do
    payload
    |> __MODULE__.generate_and_sign(Signer.create(@algorithm, %{"pem" => QitechEx.private_key()}))
  end

  def encode(_payload), do: {:error, "invalid argument type"}

  def decode(token) when is_binary(token) do
    token
    |> __MODULE__.verify_and_validate(
      Signer.create(@algorithm, %{"pem" => QitechEx.public_key()})
    )
  end

  def decode(_token), do: {:error, "invalid argument type"}

  def headers(authorization) do
    api_client_key = QitechEx.api_client_key()

    [
      {"api-client-key", api_client_key},
      {"authorization", "QIT #{api_client_key}:#{authorization}"}
    ]
  end

  def md5(content), do: Base.encode16(:erlang.md5(content), case: :lower)

  def signature_json(signature),
    do: %{"sub" => QitechEx.api_client_key(), "signature" => signature}

  def string_to_sign(http_verb, content_md5, content_type, date, relative_url)
      when is_nil(content_md5) do
    "#{http_verb}\n\n#{content_type}\n#{date}\n#{relative_url}"
  end

  def string_to_sign(http_verb, content_md5, content_type, date, relative_url),
    do: "#{http_verb}\n#{content_md5}\n#{content_type}\n#{date}\n#{relative_url}"
end
