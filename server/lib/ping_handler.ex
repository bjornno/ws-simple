defmodule PingHandler do
  def init(_any, req) do
    subscribe
    {:ok, req, nil}
  end

  # send the message back to all clients, including the sender itself
  def stream(msg, req, state) do
   IO.puts "Received message #{msg}"
    broadcast msg
    {:reply, msg, req, state}
  end

  # A callback from gproc to broadcast msg to all clients
  def info({:ping, msg}, req, state) do
    {:reply, msg, req, state}
  end

  def info(_info, req, state) do
    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end

  ## Private functions ##

  defp subscribe do
    :gproc.reg {:p, :l, :ping}
  end

  defp broadcast(msg) do
    :gproc.send {:p, :l, :ping},
                {:ping, msg}
  end
end