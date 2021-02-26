defmodule QITech.Middleware.SimplifyResponse do
  @behaviour Tesla.Middleware

  def call(env, next, simplify) do
    env
    |> Tesla.run(next)
    |> handle_response(simplify)
  end

  defp handle_response({:ok, %Tesla.Env{status: status, body: body}}, true) when status < 300,
    do: body

  defp handle_response({:ok, %Tesla.Env{} = response}, true),
    do: {:error, %{body: response.body, status: response.status}}

  defp handle_response({:error, _reason} = error, true), do: error

  defp handle_response(env, false), do: env
end
