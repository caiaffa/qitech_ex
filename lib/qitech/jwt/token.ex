defmodule QITech.JWT.Token do
  @moduledoc false
  use Joken.Config

  alias Joken.Signer
  @algorithm "ES512"

  @impl true
  def token_config, do: %{}

  @doc """
  Encode a signed data token

  ## Examples

      iex> QITech.JWT.Token.encode(%{"test" => "test"})
      {:ok, "eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0ZXN0IjoidGVzdCJ9.AE_VTyCU860U4bJVfkUu5KaN1FZ5tAdanxHG3P1OTifItrsDhr8FqD4ei66G9AwE9wTHciiRIQAaH0tmurtpFKhIAGUStHG_aYlBaR15i6xrbx5XIRdEEZioWMvyCuTdAZx7xAU88IAfVhx34LV-tCFgI7EQUqB9u7xKd67MYS10qPGq", %{"test" => "test"}}

      iex> QITech.JWT.Token.encode("test")
      {:error, "invalid argument type"}

  """
  def encode(data) when is_map(data) do
    data
    |> __MODULE__.generate_and_sign(Signer.create(@algorithm, %{"pem" => QITech.private_key()}))
  end

  def encode(_data), do: {:error, "invalid argument type"}

  @doc """
  Decode a signed data token

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

  defp headers(api_client_key, authorization) do
    [
      {"api-client-key", api_client_key},
      {"authorization", "QIT #{api_client_key}:#{authorization}"}
    ]
  end

  defp md5(content), do: Base.encode16(:erlang.md5(content), case: :lower)

  defp signature_json(signature, sub),
    do: %{"sub" => sub, "signature" => signature}

  defp string_to_sign(http_verb, content_md5, content_type, date, relative_url)
       when is_nil(content_md5) do
    "#{http_verb}\n\n#{content_type}\n#{date}\n#{relative_url}"
  end

  defp string_to_sign(http_verb, content_md5, content_type, date, relative_url),
    do: "#{http_verb}\n#{content_md5}\n#{content_type}\n#{date}\n#{relative_url}"

  @doc """
  Creates encoded and MD5 hash body
  """
  def encode_body_and_hash(paylaod) when is_map(paylaod) do
    {:ok, encoded_body, _} = encode(paylaod)
    content_md5 = md5(encoded_body)
    {:ok, encoded_body, content_md5}
  end

  def encode_body_and_hash(_paylaod), do: {:error, "invalid argument type"}

  @doc """
  Creates and signs the header
  """
  def create_header(opts) do
    http_verb = opts[:http_verb] |> to_string() |> String.upcase()
    date = Timex.now() |> Timex.format!("%a, %d %b %Y %H:%M:%S GMT", :strftime)
    relative_url = URI.parse(opts[:url]) |> relative_url()

    {:ok, authorization, _} =
      string_to_sign(http_verb, opts[:content_md5], opts[:content_type], date, relative_url)
      |> signature_json(QITech.api_client_key())
      |> encode()

    QITech.api_client_key()
    |> headers(authorization)
  end

  defp relative_url(%URI{path: path, query: query}) when is_nil(query), do: path
  defp relative_url(%URI{path: path, query: query}), do: "#{path}?#{query}"
end
