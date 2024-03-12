defmodule NanoPlannerWeb.UserSessionControllerTest do
  use NanoPlannerWeb.ConnCase

  describe "Get /users/log_in" do
    test "ログインフォームを表示する", %{conn: conn} do
      conn = get(conn, "/users/log_in")

      assert Phoenix.Controller.view_template(conn) == "new.html"
    end
  end  
end
