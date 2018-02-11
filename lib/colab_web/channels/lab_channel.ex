defmodule ColabWeb.LabChannel do
  use ColabWeb, :channel

  def join("lab:room:" <> lab_id, _message, socket) do
    Colab.Metronome.start_link(lab_id)
    {:ok, assign(socket, :lab_id, String.to_integer(lab_id))}
  end

  def handle_in("update_cell", %{"track_id" => track_id, "is_active" => is_active, "id" => id}, socket) do
    broadcast! socket, "update_cell", %{id: id, track_id: track_id, is_active: is_active}
    {:noreply, socket}
  end

  def handle_in("update_bpm", %{"bpm" => bpm}, socket) do
    GenServer.cast({:global, "lab_#{socket.assigns[:lab_id]}_metronome"}, {:set_bpm, bpm})
    broadcast! socket, "update_bpm", %{bpm: bpm}
    {:noreply, socket}
  end
end
