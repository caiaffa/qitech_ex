defmodule QITech.API.Base do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, QitechEx.base_url())
  plug(QITech.Middleware.SimplifyResponse, QitechEx.simplify_response())
  plug(QITech.Middleware.Auth)
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Opts, QitechEx.client_adapter_opts())
end
