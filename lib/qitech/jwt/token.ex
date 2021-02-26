defmodule QITech.JWT.Token do
  @moduledoc """
  This module provides helpers for working with authentication and security.

  [Documentation](https://qitech.com.br/documentacao?file=221)
  """
  use Joken.Config

  alias Joken.Signer
  @algorithm "ES512"

  @impl true
  def token_config, do: %{}

  @doc """
  Encode a signed payload token

  ## Parameters

    - payload: Map data structure

  ## Examples

      iex> QITech.JWT.Token.encode(%{"test" => "test"})
      {:ok, "eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0ZXN0IjoidGVzdCJ9.AE_VTyCU860U4bJVfkUu5KaN1FZ5tAdanxHG3P1OTifItrsDhr8FqD4ei66G9AwE9wTHciiRIQAaH0tmurtpFKhIAGUStHG_aYlBaR15i6xrbx5XIRdEEZioWMvyCuTdAZx7xAU88IAfVhx34LV-tCFgI7EQUqB9u7xKd67MYS10qPGq",
      %{"test" => "test"}

      iex> QITech.JWT.Token.encode("test")
      {:error, "invalid argument type"}

  """
  def encode(payload) when is_map(payload) do
    payload
    |> __MODULE__.generate_and_sign(Signer.create(@algorithm, %{"pem" => QITech.private_key()}))
  end

  def encode(_payload), do: {:error, "invalid argument type"}

  @doc """
  Decode a signed payload token

  ## Parameters

    - token: String

  ## Examples

      iex> QITech.JWT.Token.decode(test)
      {:ok, %{"test" => "test"}}

      iex> QITech.JWT.Token.decode(%{"test" => "test"})
      {:error, "invalid argument type"}

      iex> QITech.JWT.Token.decode("eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0ZXN0IjoidGVz")
      {:error, :signature_error}

  """
  def decode(token) when is_binary(token) do
    token
    |> __MODULE__.verify_and_validate(Signer.create(@algorithm, %{"pem" => QITech.public_key()}))
  end

  def decode(_token), do: {:error, "invalid argument type"}

  @doc """
  QITEch API Headers

  [Documentation](https://qitech.com.br/documentacao?file=222)
  """
  def headers(authorization) do
    api_client_key = QITech.api_client_key()

    [
      {"api-client-key", api_client_key},
      {"authorization", "QIT #{api_client_key}:#{authorization}"}
    ]
  end

  def md5(content), do: Base.encode16(:erlang.md5(content), case: :lower)

  @doc """
  QITEch Signature Json

  [Documentation](https://qitech.com.br/documentacao?file=222)
  """
  def signature_json(signature),
    do: %{"sub" => QITech.api_client_key(), "signature" => signature}

  @doc """
  QITEch String To Sign

  [Documentation](https://qitech.com.br/documentacao?file=222)
  """
  def string_to_sign(http_verb, content_md5, content_type, date, relative_url)
      when is_nil(content_md5) do
    "#{http_verb}\n\n#{content_type}\n#{date}\n#{relative_url}"
  end

  def string_to_sign(http_verb, content_md5, content_type, date, relative_url),
    do: "#{http_verb}\n#{content_md5}\n#{content_type}\n#{date}\n#{relative_url}"
end
