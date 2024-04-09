defmodule NanoPlannerWeb.UserSessionControllerTest do
  use NanoPlannerWeb.ConnCase
  import NanoPlanner.AccountsFixtures

  describe "Get /users/log_in" do
    setup do
      user = user_fixture(login_name: "alice")
      {:ok, user: user}
    end

    test "ログインフォームを表示する", %{conn: conn} do
      conn = get(conn, "/users/log_in")

      assert Phoenix.Controller.view_template(conn) == "new.html"
    end

    test "トップページにリダイレクトする", %{conn: conn, user: user} do
      conn =
        conn
        |> log_in_user(user)
        |> get("/users/log_in")

      assert redirected_to(conn) == "/"
    end
  end  
end
