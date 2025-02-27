defmodule RustDetector do
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

Benchee.run(
  %{
    "elixir" => fn inputs -> Enum.each(inputs, &UAInspector.parse/1) end,
    "rust port" =>
      {fn %{inputs: inputs, port: port} ->
         Enum.each(inputs, fn ua -> RustDetector.parse(port, ua) end)
       end,
       before_scenario: fn inputs ->
         cmd =
           System.get_env(
             "RUST_DETECTOR_PATH",
             "/Users/x/Developer/plausible/rust-device-detector/target/release/rust-device-detector"
           )

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

         %{port: port, inputs: inputs}
       end}
  },
  inputs: %{
    "1k random from devices.txt" => Enum.take_random(File.stream!("bench/devices.txt"), 1000)
  }
)
