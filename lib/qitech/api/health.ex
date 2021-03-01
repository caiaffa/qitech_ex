defmodule QITech.API.Health do
  @moduledoc """
  Provides Health API interfaces.

  You can:
  - Check rest api is working fine or not

  [QI Tech API reference](https://qitech.com.br/documentacao?file=221)
  """
  alias QITech.API.Base

  @test_path "/test"

  @doc """
  Health API.

  ## Examples

      iex> QITech.API.Health.ping()
      {:ok, %{body: %{"ping" => "pong", "success" => "Congrats!"}, status: 201}}
  """
  def ping do
    Base.post(@test_path, %{"ping" => "pong"})
  end
end
