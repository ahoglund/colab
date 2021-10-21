defmodule Colab.Repo do
  use Ecto.Repo,
    otp_app: :colab,
    adapter: Ecto.Adapters.Postgres
end
