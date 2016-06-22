defmodule WebSocketServer do
  @behaviour :application

  def start(_type, _args) do
    dispatch = :cowboy_router.compile([
      {:_, [
        {'/_ws', WebSocketHandler, [{:ping, PingHandler}]}      
                                    ]}
    ])
    :cowboy.start_http :my_http_listener, 100, [{:port, 8090}], [{:env, [{:dispatch, dispatch}]}]
    IO.puts "Started listening on port 8090..."

    WebSocketSup.start_link
  end

  def stop(_state) do
    :ok
  end
end