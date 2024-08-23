require 'benchmark'
require 'thread'

# Number of iterations for the benchmark
iterations = 100

# Benchmark for thread context switching
thread_time = Benchmark.realtime do
  threads = []
  iterations.times do
    threads << Thread.new {}
  end
  threads.each(&:join)
end

# Benchmark for process context switching
process_time = Benchmark.realtime do
  iterations.times do
    fork { exit }
    Process.wait
  end
end

puts "Thread context switching time: #{thread_time} seconds"
puts "Process context switching time: #{process_time} seconds"
