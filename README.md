A quick and dirty device detector benchmark. Assumes https://github.com/simplecastapps/rust-device-detector is already compiled and the path to the binary is set in `RUST_DETECTOR_PATH`.

Here's what I get right now:

```console
$ MIX_ENV=bench mix ua_inspector.download 
$ MIX_ENV=bench RUST_DETECTOR_PATH=../rust-device-detector/target/release/rust-device-detector mix run bench/ua.exs
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 8 GB
Elixir 1.18.1
Erlang 27.2
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 4
inputs: 10 random from devices.txt, 100 random from devices.txt, all devices.txt
Estimated total run time: 42 s

##### With input 10 random from devices.txt #####
Name                ips        average  deviation         median         99th %
rust port         16.79       59.57 ms    ±52.57%       56.83 ms      343.61 ms
elixir             1.83      545.12 ms     ±6.28%      525.86 ms      609.34 ms

Comparison:
rust port         16.79
elixir             1.83 - 9.15x slower +485.55 ms

##### With input 100 random from devices.txt #####
Name                ips        average  deviation         median         99th %
rust port          1.55         0.64 s    ±16.31%         0.60 s         0.86 s
elixir            0.182         5.50 s     ±0.44%         5.50 s         5.51 s

Comparison:
rust port          1.55
elixir            0.182 - 8.53x slower +4.85 s

##### With input all devices.txt #####
Name                ips        average  deviation         median         99th %
rust port        0.0963        10.38 s     ±0.16%        10.38 s        10.40 s
elixir           0.0180        55.54 s     ±0.08%        55.55 s        55.59 s

Comparison:
rust port        0.0963
elixir           0.0180 - 5.35x slower +45.16 s
```
