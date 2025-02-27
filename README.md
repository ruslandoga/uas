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
parallel: 1
inputs: 1k random from devices.txt
Estimated total run time: 14 s

Benchmarking elixir with input 1k random from devices.txt ...
Benchmarking rust port with input 1k random from devices.txt ...
Rust says: Starting interactive mode
Calculating statistics...
Formatting results...

##### With input 1k random from devices.txt #####
Name                ips        average  deviation         median         99th %
elixir             5.38        0.186 s     ±6.78%        0.184 s         0.25 s
rust port         0.172         5.81 s     ±0.00%         5.81 s         5.81 s

Comparison:
elixir             5.38
rust port         0.172 - 31.22x slower +5.62 s
```
