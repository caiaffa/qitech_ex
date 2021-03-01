defmodule QITech.API.Base do
  @moduledoc false
  use Tesla

  adapter(Tesla.Adapter.Hackney)

  plug(Tesla.Middleware.BaseUrl, QITech.base_url())
  plug(QITech.Middleware.SimplifyResponse, QITech.simplify_response())
  plug(QITech.Middleware.Auth)
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Opts, QITech.client_adapter_opts())

  def encode_url_query_params(url, params) when params == [], do: url

  def encode_url_query_params(url, params) do
    url
    |> URI.parse()
    |> Map.put(:query, URI.encode_query(params))
    |> URI.to_string()
  end
end
