defmodule EchoIp.Controllers.Main do
  use Sugar.Controller
  require Logger

  def index(conn, []) do
    raw conn |> resp(200, "Hello world")
  end

  def ip(conn, []) do
    x_fwd = Plug.Conn.get_req_header(conn, "x-forwarded-for")
    Logger.debug(x_fwd)
    # {ip__, _} = conn.peer
    # ip_ = ip__
    ip_ = conn.remote_ip
          |> Tuple.to_list
          |> List.foldr "", fn (x, acc) -> "." <> Integer.to_string(x) <> acc end
    json conn, %{ip: String.slice(ip_, 1, String.length(ip_))}
  end
end
