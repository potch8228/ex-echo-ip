defmodule EchoIp.Controllers.Main do
  use Sugar.Controller

  def index(conn, []) do
    raw conn |> resp(200, "Hello world")
  end

  def ip(conn, []) do
    ip_ = conn.remote_ip
          |> Tuple.to_list
          |> List.foldr "", fn (x, acc) -> "." <> Integer.to_string(x) <> acc end
    json conn, %{ip: String.slice(ip_, 1, String.length(ip_))}
  end
end
