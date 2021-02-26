defmodule QITech.API.Debt do
  alias QITech.API.Base

  @debt_path "/debt"
  @signed_debt_path "signed_debt"

  def get() do
    Base.get(@debt_path)
  end

  def create(body) do
    Base.post(@debt_path, body)
  end

  def create_signed(body) do
    Base.post(@signed_debt_path, body)
  end

  def get_signed() do
    Base.get(@signed_debt_path)
  end
end
