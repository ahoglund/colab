defmodule Colab.LabViewTest do
  use Colab.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    labs = [%Colab.Lab{id: 1, name: "Test Lab"},
            %Colab.Lab{id: 2, name: "Test Lab 2"}]

    content = render_to_string(Colab.LabView, "index.html", conn: conn, labs: labs)

    for lab <- labs do
      assert String.contains?(content, lab.name)
    end
  end

  test "renders show.html", %{conn: conn} do
    lab = %Colab.Lab{id: 1, name: "Test Lab"}
    content = render_to_string(Colab.LabView, "show.html", conn: conn, lab: lab)

    assert String.contains?(content, lab.name)
  end
end
