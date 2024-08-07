defmodule NanoPlannerWeb.PlanItemControllerTest do
  use NanoPlannerWeb.ConnCase
  import NanoPlanner.ScheduleFixtures
  import NanoPlanner.AccountsFixtures
  alias NanoPlanner.Repo
  alias NanoPlanner.Schedule.PlanItem

  describe "GET /plan_items" do
    setup context do
      plan_item_fixture(owner: context[:user])
      plan_item_fixture(owner: context[:user])
      user = user_fixture(login_name: "alice")
      {:ok, user: user}
    end
    
    test "予定項目の一覧を表示する", %{conn: conn, user: user} do
      conn =
        conn
        |> log_in_user(user)
        |> get("/plan_items")

      assert conn.status == 200

      plan_items = conn.assigns[:plan_items]

      assert is_list(plan_items)
      assert length(plan_items) == 2
    end

    test "ログインフォームにリダイレクトする", %{conn: conn} do
      conn = get(conn, "/plan_items")
  
      assert redirected_to(conn) == "/users/log_in"
    end
  end

  describe "POST /plan_items" do
    setup do
      user = user_fixture(login_name: "alice")
      {:ok, user: user}
    end

    test "予定項目を追加する", %{conn: conn, user: user} do
      params = %{
        "plan_item" => %{
          "name" => "Test",
          "description" => "",
          "all_day" => "false",
          "s_date" => "2021-08-01",
          "s_hour" => "12",
          "s_minute" => "00",
          "e_date" => "2021-08-01",
          "e_hour" => "13",
          "e_minute" => "00"
        }
      }

      conn =
        conn
        |> log_in_user(user)
        |> post("/plan_items", params)

      assert conn.status == 302
      assert redirected_to(conn) == "/plan_items"

      fetched = Repo.all(PlanItem)
      assert length(fetched) == 1

      [item] = fetched
      assert item.name == "Test"
    end
  end
end
