defmodule NanoPlanner.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use NanoPlanner.DataCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate
  import NanoPlanner.AccountsFixtures

  using do
    quote do
      alias NanoPlanner.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import NanoPlanner.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(NanoPlanner.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(NanoPlanner.Repo, {:shared, self()})
    end

    user =
      if tags[:login] do
        login_name = tags[:login_name] || "alice"
        user_fixture(login_name: login_name)
      end
    
    {:ok, user: user}
  end

  @doc """
  A helper that transforms changeset errors into a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
