defmodule EchoIp do
  use Application

  def start(_type, _args) do
    EchoIp.Router.run
  end
end
