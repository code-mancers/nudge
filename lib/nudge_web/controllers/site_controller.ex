defmodule NudgeWeb.SiteController do
  use NudgeWeb, :controller
  alias Nudge.Accounts
  alias Nudge.Accounts.Site

  def index(conn, _params) do
    current_user_id = conn.assigns.current_user.id
    user_sites = Accounts.list_user_sites(current_user_id)
    render(conn, "index.html", sites: user_sites)
  end

  def new(conn, _params) do
    changeset = Accounts.change_site(%Site{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"site" => %{"active" => active, "tz" => tz, "url" => url}}) do
    case Accounts.create_site(%{active: active, tz: tz, url: url, user_id: conn.assigns.current_user.id}) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site created successfully.")
        |> redirect(to: Routes.site_path(conn, :show, site))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    site = Accounts.get_site!(id)
    changeset = Accounts.change_site(site)
    render(conn, "edit.html", site: site, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site" => site_params}) do
    site = Accounts.get_site!(id)

    case Accounts.update_site(site, site_params) do
      {:ok, site} ->
        redirect(conn, to: Routes.site_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", site: site, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    site = Accounts.get_site!(id)
    render(conn, "show.html", site: site)
  end
end
