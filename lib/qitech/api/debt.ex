defmodule QITech.API.Debt do
  @moduledoc """
  Provides debt API interfaces.

  You can:
  - Create a debt
  - Retrieve a debt or a list of debts
  - Cancel a debt

  [QI Tech API reference](https://qitech.com.br/documentacao?file=447)
  """

  alias QITech.API.Base

  @debt_path "/debt"
  @debt_simulation_path "/debt_simulation"
  @signed_debt_path "/signed_debt"

  @doc """
  Retrieve a debt or a list of debts

  ## Examples

      iex> QITech.API.Debt.get()

      iex> QITech.API.Debt.get(
        [status: "opened", issuer_document_number: "31658725833", issuer_name: "Name Example", profile_document_number: "31658725833", page: 1, page_size: 100]
      )
  """
  def get(query_params \\ nil) do
    @debt_path |> Base.encode_url_query_params(query_params) |> Base.get()
  end

  @doc """
  Create a debt.

  ## Examples

      iex> QITech.API.Debt.create(%{})
  """
  def create(body) do
    Base.post(@debt_path, body)
  end

  @doc """
  Create a signed debt.

  ## Examples

      iex> QITech.API.Debt.create(%{})
  """
  def create_signed(body) do
    Base.post(@signed_debt_path, body)
  end

  @doc """
  Retrieve a signed debt or a list of signed debts.

  ## Examples

      iex> QITech.API.Debt.get_signed()


      iex> QITech.API.Debt.get_signed(
        [status: "opened", issuer_document_number: "31658725833", issuer_name: "Name Example", profile_document_number: "31658725833", page: 1, page_size: 100]
      )
  """
  def get_signed(query_params \\ nil) do
    @signed_debt_path |> Base.encode_url_query_params(query_params) |> Base.get()
  end

  @doc """
  Simulation a debt.

  ## Examples

      iex> QITech.API.Debt.simulation(%{})
  """
  def simulation(body) do
    Base.post(@debt_simulation_path, body)
  end

  @doc """
  Cancel a debt.

  ## Examples

      iex> QITech.API.Debt.cancel("8c3c7f72-cd87-4067-9b40-4b3483014d0f")
  """
  def cancel(operation_key, body \\ %{}) do
    Base.patch("#{@debt_path}/#{operation_key}/cancel", body)
  end
end
