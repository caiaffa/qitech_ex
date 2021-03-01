defmodule QITech.API.BaseTest do
  use ExUnit.Case

  alias QITech.API.Base

  test "encode url with query params" do
    assert "test?status=canceled" == Base.encode_url_query_params("test", status: "canceled")
  end

  test "encode url without query params" do
    assert "test" == Base.encode_url_query_params("test", [])
  end
end
