defmodule NanoPlannerWeb.TopControllerTest do
  use NanoPlannerWeb.ConnCase, async: true
  import NanoPlanner.AccountsFixtures

  describe "GET /" do
    setup do
      user = user_fixture(login_name: "alice")
      {:ok, user: user}
    end

    test "ウェルカムページを表示する", %{conn: conn} do
      conn = get(conn, "/")

      assert Phoenix.Controller.view_template(conn) == "welcome.html"
    end

    test "ログイン後のトップページを表示する", %{conn: conn, user: user} do
      conn =
        conn
        |> log_in_user(user)
        |> get("/")

      assert Phoenix.Controller.view_template(conn) == "index.html"
    end
  end
end
