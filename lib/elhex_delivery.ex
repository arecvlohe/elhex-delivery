defmodule ElhexDelivery do
  use Application

  def start(_start_type, _start_args) do
    ElhexDelivery.Supervisor.start_link
  end
end
