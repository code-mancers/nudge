defmodule NudgeWeb.SiteControllerTest do
  use NudgeWeb.ConnCase
  use Plug.Test

  @create_attrs %{active: true, tz: "UTC", url: "https://example.com"}
  @invalid_attrs %{active: nil, tz: nil, url: nil}

  describe "create site" do
    setup [:create_user]

    test "redirects after creating when data is valid", %{conn: conn, user: user} do
      conn = Plug.Test.init_test_session(conn, user_id: user.id)

      conn = post(conn, Routes.site_path(conn, :create), site: @create_attrs)
      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.site_path(conn, :show, id)
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = Plug.Test.init_test_session(conn, user_id: user.id)
      conn = post(conn, Routes.site_path(conn, :create), site: @invalid_attrs)
      assert html_response(conn, 200) =~ "Create Site"
    end
  end

  defp fixture(:user) do
    user_attrs = %{
      "email" => "abc@email.com",
      "password" => "passworddd",
      "name" => "name"
    }

    {:ok, user} = Nudge.Accounts.create_user(user_attrs)
    user
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
