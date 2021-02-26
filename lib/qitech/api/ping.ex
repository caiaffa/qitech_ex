defmodule QITech.API.Ping do
  @moduledoc """
  Provides ping API interfaces.

  [Documentation](https://qitech.com.br/documentacao?file=447)
  """
  alias QITech.API.Base

  @test_path "/test"

  @doc """
  Test  Api.

  You can see more in documentation

  ## Examples

      iex> QITech.API.Ping.ping()
      {:ok, %{body: %{"ping" => "pong", "success" => "Congrats!"}, status: 201}}
  """
  def ping do
    Base.post(@test_path, %{"ping" => "pong"})
  end
end
