defmodule QITech.API.Debt do
  @moduledoc """
  Provides debt API interfaces.

  [Documentation](https://qitech.com.br/documentacao?file=447)
  """

  alias QITech.API.Base

  @debt_path "/debt"
  @debt_simulation_path "/debt_simulation"
  @signed_debt_path "/signed_debt"

  @doc """
  Returns one or list of debts.

  ## Parameters

    - params: Keyword lists

  ## Examples

      iex> QITech.API.Debt.get()
      iex> QITech.API.Debt.get(
        [status: "opened", issuer_document_number: "31658725833", issuer_name: "Name Example", profile_document_number: "31658725833", page: 1, page_size: 100]
      )
  """
  def get(params \\ nil) do
    @debt_path |> Base.encode_url_query_params(params) |> Base.get()
  end

  @doc """
  Create  debt.

  You can see more in documentation

  ## Parameters

    - body: Map data structure

  ## Examples

      iex> QITech.API.Debt.create(%{})
  """
  def create(body) do
    Base.post(@debt_path, body)
  end

  @doc """
  Create  signed debt.

  You can see more in documentation

  ## Parameters

    - body: Map data structure

  ## Examples

      iex> QITech.API.Debt.create(%{})
  """
  def create_signed(body) do
    Base.post(@signed_debt_path, body)
  end

  @doc """
  Returns one or list of signed debt.

  ## Parameters

    - params: Keyword lists

  ## Examples

      iex> QITech.API.Debt.get_signed()
      iex> QITech.API.Debt.get_signed(
        [status: "opened", issuer_document_number: "31658725833", issuer_name: "Name Example", profile_document_number: "31658725833", page: 1, page_size: 100]
      )
  """
  def get_signed(params \\ nil) do
    @signed_debt_path |> Base.encode_url_query_params(params) |> Base.get()
  end

  @doc """
  Simulation debt.

  You can see more in documentation

  ## Parameters

    - body: Map data structure

  ## Examples

      iex> QITech.API.Debt.simulation(%{})
  """
  def simulation(body) do
    Base.post(@debt_simulation_path, body)
  end
end
