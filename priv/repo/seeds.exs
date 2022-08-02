# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BorutaExample.Repo.insert!(%BorutaExample.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

id = SecureRandom.uuid()
secret = SecureRandom.hex(64)

Boruta.Ecto.Admin.create_client(%{
  id: id, # OAuth client_id
  secret: secret, # OAuth client_secret
  name: "A client", # Display name
  access_token_ttl: 60 * 60 * 24, # one day
  authorization_code_ttl: 60, # one minute
  refresh_token_ttl: 60 * 60 * 24 * 30, # one month
  id_token_ttl: 60 * 60 * 24, # one day
  id_token_signature_alg: "RS256", # ID token signature algorithm, defaults to "RS512"
  redirect_uris: ["http://redirect.uri"], # OAuth client redirect_uris
  authorize_scope: true, # take following authorized_scopes into account (skip public scopes)
  authorized_scopes: [%{name: "openid email"}], # scopes that are authorized using this client
  supported_grant_types: [ # client supported grant types
    "client_credentials",
    "password",
    "authorization_code",
    "refresh_token",
    "implicit",
    "revoke",
    "introspect"
  ],
  pkce: false, # PKCE enabled
  public_refresh_token: false, # do not require client_secret for refreshing tokens
  public_revoke: false # do not require client_secret for revoking tokens
}) |> IO.inspect
