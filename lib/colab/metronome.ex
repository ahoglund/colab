defmodule Colab.Metronome do
  use GenServer

  def set_bpm(pid, bpm), do: GenServer.cast(pid, {:set_bpm, bpm})

  def get_bpm(pid), do: GenServer.call(pid, :get_bpm)

  def start_link(lab_id) do
    GenServer.start_link(__MODULE__, %{lab_id: lab_id, tick: 1, bpm: 120}, name: {:global, "lab_#{lab_id}_metronome"} )
  end

  def init(%{lab_id: lab_id, tick: tick, bpm: bpm}) do
    Process.send_after(self, :tick, calculate(tick, bpm))
    {:ok, %{lab_id: lab_id, tick: tick + 1, bpm: bpm}}
  end

  def handle_info(:tick, %{lab_id: lab_id, tick: tick, bpm: bpm}) do
    Process.send_after(self, :tick, calculate(tick, bpm))
    ColabWeb.Endpoint.broadcast_from! self, "lab:room:#{lab_id}",
      "metronome_tick", %{lab_id: lab_id, tick: tick, bpm: bpm}
    {:noreply, %{lab_id: lab_id, tick: tick + 1, bpm: bpm}}
  end

  def handle_cast({:set_bpm, bpm}, state) do
    {:noreply, %{ state | bpm: bpm }}
  end

  def handle_call(:get_bpm, _from, state) do
    {:reply, state, state}
  end

  defp calculate(_tick, bpm) do
    60_000 |> div(bpm) |> div(4)
  end
end
