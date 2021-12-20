defmodule QITech.API.BankSlip do
  @moduledoc """
  Provides bank slip API interfaces.

  You can:
  - Retrieve a bank slip

  [QI Tech API reference](https://qitech.com.br/documentacao?file=0885)
  """

  alias QITech.API.Base

  @bank_slip_path "/bank_slip"

  @doc """
  Retrieve a bank slip

  ## Examples

      iex> QITech.API.BankSlip.get("cddd68af-a7e4-4abc-84f2-04ab27b1d9b1")
  """
  def get(bank_slip_key) do
    "#{@bank_slip_path}/#{bank_slip_key}" |> Base.get()
  end

  @doc """
  Retrieve a copy of the bank slip

  ## Examples

      iex> QITech.API.BankSlip.post("cddd68af-a7e4-4abc-84f2-04ab27b1d9b1", %{})
  """
  def copy(bank_slip_key, body \\ %{}) do
    "#{@bank_slip_path}/2-way/#{bank_slip_key}" |> Base.post(body)
  end
end
