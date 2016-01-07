defmodule EchoIp.Router do
  use Sugar.Router
  plug Sugar.Plugs.HotCodeReload

  if Sugar.Config.get(:sugar, :show_debugger, false) do
    use Plug.Debugger, otp_app: :echo_ip
  end

  plug Plug.Static, at: "/static", from: :echo_ip

  # Uncomment the following line for session store
  # plug Plug.Session, store: :ets, key: "sid", secure: true, table: :session

  # Define your routes here
  get "/", EchoIp.Controllers.Main, :index
  get "/ip", EchoIp.Controllers.Main, :ip
end
