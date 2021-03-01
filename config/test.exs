use Mix.Config

config :tesla, QITech.API.Base, adapter: Tesla.Mock

config :qitech,
  sandbox: true,
  simplify_response: true,
  # faker apli client key
  api_client_key: "df6a3c0f-a5e2-4935-9d5c-3065cd417476",
  client_adapter_opts: [adapter: [recv_timeout: 30_000]],
  # private and publick key generate by https://jwt.io/, do not commit in real scenario
  public_key: """
  -----BEGIN PUBLIC KEY-----
  MIGbMBAGByqGSM49AgEGBSuBBAAjA4GGAAQBgc4HZz+/fBbC7lmEww0AO3NK9wVZ
  PDZ0VEnsaUFLEYpTzb90nITtJUcPUbvOsdZIZ1Q8fnbquAYgxXL5UgHMoywAib47
  6MkyyYgPk0BXZq3mq4zImTRNuaU9slj9TVJ3ScT3L1bXwVuPJDzpr5GOFpaj+WwM
  Al8G7CqwoJOsW7Kddns=
  -----END PUBLIC KEY-----
  """,
  private_key: """
  -----BEGIN EC PRIVATE KEY-----
  MIHcAgEBBEIBiyAa7aRHFDCh2qga9sTUGINE5jHAFnmM8xWeT/uni5I4tNqhV5Xx
  0pDrmCV9mbroFtfEa0XVfKuMAxxfZ6LM/yKgBwYFK4EEACOhgYkDgYYABAGBzgdn
  P798FsLuWYTDDQA7c0r3BVk8NnRUSexpQUsRilPNv3SchO0lRw9Ru86x1khnVDx+
  duq4BiDFcvlSAcyjLACJvjvoyTLJiA+TQFdmrearjMiZNE25pT2yWP1NUndJxPcv
  VtfBW48kPOmvkY4WlqP5bAwCXwbsKrCgk6xbsp12ew==
  -----END EC PRIVATE KEY-----
  """
