defmodule QITech.API.Test do
  @moduledoc """
  Provides test API interfaces.

  You can:
  - Test if rest api is working fine or not

  [QI Tech API reference](https://qitech.com.br/documentacao?file=221)
  """
  alias QITech.API.Base

  @test_path "/test"

  @doc """
  Test API.

  ## Examples

      iex> QITech.API.Test.ping()
      {:ok, %{body: %{"ping" => "pong", "success" => "Congrats!"}, status: 201}}
  """
  def ping do
    Base.post(@test_path, %{"ping" => "pong"})
  end
end
