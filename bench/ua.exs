devices = Enum.to_list(File.stream!("bench/devices.txt"))

Benchee.run(
  %{
    "elixir" => fn inputs -> Enum.each(inputs, &UAInspector.parse/1) end,
    "rust port" =>
      {fn %{inputs: inputs, port: port} ->
         Enum.each(inputs, fn ua -> RustDetector.parse(port, ua) end)
       end,
       before_scenario: fn inputs ->
         port = RustDetector.open(System.fetch_env!("RUST_DETECTOR_PATH"))
         %{port: port, inputs: inputs}
       end}
  },
  inputs: %{
    "10 random from devices.txt" => Enum.take_random(devices, 10),
    "100 random from devices.txt" => Enum.take_random(devices, 100),
    "all devices.txt" => Enum.shuffle(devices)
  },
  parallel: 4
)
