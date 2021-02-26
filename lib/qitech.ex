defmodule QITech do
  @moduledoc """
  Documentation for `QITech`.
  """

  @base_url "https://api-auth.qitech.app"
  @base_url_sandbox "https://api-auth.sandbox.qitech.app"

  def api_client_key, do: Application.get_env(:qitech, :api_client_key)

  def private_key, do: Application.get_env(:qitech, :private_key)

  def public_key, do: Application.get_env(:qitech, :public_key)

  def base_url do
    case Application.get_env(:qitech, :sandbox) do
      true -> @base_url_sandbox
      false -> @base_url
    end
  end

  def simplify_response, do: Application.get_env(:qitech, :simplify_response)

  def client_adapter_opts, do: Application.get_env(:qitech, :client_adapter_opts)
end
