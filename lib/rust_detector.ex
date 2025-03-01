defmodule RustDetector do
  def open(cmd) do
    port =
      Port.open(
        {:spawn_executable, cmd},
        [
          :binary,
          :exit_status,
          :stderr_to_stdout,
          :line,
          args: ["--interactive"]
        ]
      )

    receive do
      {^port, {:data, {:eol, msg}}} -> IO.puts("Rust says: " <> msg)
    end

    port
  end

  def parse(port, ua) do
    send(port, {self(), {:command, ua <> "\n"}})
    receive_all(port) |> IO.iodata_to_binary() |> :json.decode()
  end

  def receive_all(port) do
    receive do
      {^port, {:data, {:noeol, part}}} -> [part | receive_all(port)]
      {^port, {:data, {:eol, json}}} -> json
    end
  end
end
