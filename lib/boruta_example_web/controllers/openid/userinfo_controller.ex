defmodule BorutaExampleWeb.Openid.UserinfoController do
  @behaviour Boruta.Openid.UserinfoApplication

  use BorutaExampleWeb, :controller

  alias BorutaExampleWeb.OpenidView

  def openid_module, do: Application.get_env(:boruta_example, :openid_module, Boruta.Openid)

  def userinfo(conn, _params) do
    openid_module().userinfo(conn, __MODULE__)
  end

  @impl Boruta.Openid.UserinfoApplication
  def userinfo_fetched(conn, userinfo) do
    conn
    |> put_view(OpenidView)
    |> render("userinfo.json", userinfo: userinfo)
  end

  @impl Boruta.Openid.UserinfoApplication
  def unauthorized(conn, error) do
    conn
    |> put_resp_header(
      "www-authenticate",
      "error=\"#{error.error}\", error_description=\"#{error.error_description}\""
    )
    |> send_resp(:unauthorized, "")
  end

  def discovery(conn, _) do
    conn
    |> put_view(OpenidView)
    |> render("openid-configuration.json")
  end
end
