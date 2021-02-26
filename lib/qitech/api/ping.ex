defmodule QITech.API.Ping do
  alias QITech.API.Base

  @test_path "/test"

  def ping do
    Base.post(@test_path, %{"ping" => "pong"})
  end
end
