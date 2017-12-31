defmodule ElaborateImageWeb.Api.V1.ImageControllerTest do
  use ElaborateImageWeb.ConnCase, async: true
  alias Exredis.Api, as: R

  @url "https://s3.amazonaws.com/elaborate-image/demo/resized/pexels-photo-736008.jpeg"

  describe "resize/2 with an uncached url" do
    setup [:clear_cache, :fetch_path]

    test "Responds with a temporary redirect", %{conn: conn} do
      assert conn.status == 307
    end

    test "Responds with a redirect url", %{conn: conn} do
      assert get_redirect_url!(conn) === @url
    end
  end

  describe "resize/2 with cached url" do
    setup [:clear_cache, :cache_url, :fetch_path]

    test "Responds with a permenant redirect", %{conn: conn} do
      assert conn.status == 308
    end

    test "Responds with a redirect url", %{conn: conn} do
      assert get_redirect_url!(conn) === "https://example.com/image.jpeg"
    end
  end

  defp clear_cache(_context) do
    R.flushall()
  end

  defp cache_url(_context) do
    R.set(@url, "https://example.com/image.jpeg")
  end

  defp fetch_path(%{conn: conn}) do
    [
      conn:
        conn
        |> get(
          api_v1_image_path(conn, :resize),
          url: @url
        )
    ]
  end

  defp get_redirect_url!(conn) do
    conn.resp_headers
    |> Enum.find(fn resp_header -> resp_header |> elem(0) === "location" end)
    |> elem(1)
  end
end
