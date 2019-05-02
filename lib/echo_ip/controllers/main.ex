defmodule EchoIp.Controllers.Main do
  use Sugar.Controller
  require Logger

  def index(conn, []) do
    raw conn |> resp(200, "Hello world")
  end

  def ip(conn, []) do
    x_fwd = Plug.Conn.get_req_header(conn, "x-forwarded-for")

    ip_ = case x_fwd do
      _ when length(x_fwd) != 0 -> String.split(hd(x_fwd), ",") |> List.last
      _ -> conn.remote_ip |> fmt
    end

    json conn, %{ip: ip_}
  end

  defp fmt(ip) do
    ip_ = ip
          |> Tuple.to_list
          |> List.foldr "", fn (x, acc) -> "." <> Integer.to_string(x) <> acc end
    (fn i -> String.slice(i, 1, String.length(i) - 1) end).(ip_)
  end
end
