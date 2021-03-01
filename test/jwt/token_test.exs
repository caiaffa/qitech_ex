defmodule QITech.JWT.TokenTest do
  use ExUnit.Case

  alias QITech.JWT.Token

  describe "Creates and signs the header" do
    test "Create header without content md5" do
      opts = [
        http_verb: "POST",
        url: "/test",
        content_md5: nil,
        content_type: "application/json"
      ]

      [head | tail] = Token.create_header(opts)

      assert {"api-client-key", "df6a3c0f-a5e2-4935-9d5c-3065cd417476"} == head
      assert tail != []
    end

    test "Create header with content md5" do
      {_, _, content_md5} = Token.encode_body_and_hash(%{"test" => "test"})

      opts = [
        http_verb: "POST",
        url: "/test",
        content_md5: content_md5,
        content_type: "application/json"
      ]

      [head | tail] = Token.create_header(opts)

      assert {"api-client-key", "df6a3c0f-a5e2-4935-9d5c-3065cd417476"} == head
      assert tail != []
    end

    test "Create header with url query string" do
      {_, _, content_md5} = Token.encode_body_and_hash(%{"test" => "test"})

      opts = [
        http_verb: "POST",
        url: "/test?status=opened",
        content_md5: content_md5,
        content_type: "application/json"
      ]

      [head | tail] = Token.create_header(opts)

      assert {"api-client-key", "df6a3c0f-a5e2-4935-9d5c-3065cd417476"} == head
      assert tail != []
    end
  end

  describe "Encode and decode body" do
    test "Creates encoded and MD5 hash body" do
      assert {:ok, _encoded_body, _content_md5} = Token.encode_body_and_hash(%{"test" => "test"})
    end

    test "Creates encoded and MD5 hash body with invalid type" do
      assert {:error, error} = Token.encode_body_and_hash("test")
      assert error == "invalid argument type"
    end

    test "decode a signed data token" do
      assert {:ok, encoded_body, _content_md5} = Token.encode_body_and_hash(%{"test" => "test"})

      assert {:ok, %{"test" => "test"}} == Token.decode(encoded_body)
    end

    test "decode a signed data token with invalid type" do
      assert {:error, error} = Token.decode(%{"test" => "test"})
      assert error == "invalid argument type"
    end
  end
end
