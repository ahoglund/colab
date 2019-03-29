defmodule ColabWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "lab:room:*", ColabWeb.LabChannel

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
