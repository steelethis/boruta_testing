defmodule BorutaExampleWeb.OpenidView do
  use BorutaExampleWeb, :view

  def render("jwks.json", %{jwk_keys: jwk_keys}) do
    %{keys: jwk_keys}
  end

  def render("userinfo.json", %{userinfo: userinfo}) do
    userinfo
  end

  def render("openid-configuration.json", _) do
    base_url = "http://localhost:4000"
    %{
      # "authorization_endpoint"=> "#{base_url}/oauth/authorize",
      "authorization_endpoint"=> "#{base_url}/openid/authorize",
      "id_token_signing_alg_values_supported"=> [
          "RS512"
      ],
      "issuer"=> "#{base_url}",
      "jwks_uri"=> "#{base_url}/openid/jwks",
      "response_types_supported"=> [
          "client_credentials",
          "password",
          "authorization_code",
          "refresh_token",
          "implicit",
          "revoke",
          "introspect"
      ],
      "subject_types_supported"=> [
          "public"
      ],
      "token_endpoint"=> "#{base_url}/oauth/token",
      "userinfo_endpoint"=> "#{base_url}/openid/userinfo"
    }
  end
end
