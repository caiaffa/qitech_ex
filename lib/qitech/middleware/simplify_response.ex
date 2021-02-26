defmodule QITech.Middleware.SimplifyResponse do
  @moduledoc """
  Simplify Tesla Response middleware

  ## Example
  ```
  defmodule MyClient do
    use Tesla
    plug QITech.Middleware.SimplifyResponse
  end
  ```

  Possible returns:
  - {:ok, %{body: body, status: status}}
  - {:error, {body: %{}, status: 500}
  - {:error, :timeout}

  ## Options
  """
  @behaviour Tesla.Middleware

  def call(env, next, simplify) do
    env
    |> Tesla.run(next)
    |> handle_response(simplify)
  end

  defp handle_response({:ok, %Tesla.Env{status: status, body: body}}, true) when status < 300,
    do: {:ok, %{body: body, status: status}}

  defp handle_response({:ok, %Tesla.Env{} = response}, true),
    do: {:error, %{body: response.body, status: response.status}}

  defp handle_response({:error, _reason} = error, true), do: error

  defp handle_response(env, false), do: env
end
