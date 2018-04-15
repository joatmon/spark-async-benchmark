# spark-async-benchmark
Benchmark application for SparkJava async request handling

This repo contains a benchmark application with two endpoints: /data and /asyncdata

Both endpoints accept one query parameter *delay* that can be set to the number of milliseconds
that the request will pause before returning. For example:
```
curl http://localhost:4567/asyncdata?delay=2000
```

# Sample benchmark
The bin/wrk_sync.sh and bin/wrk_async.sh scripts do the same thing, but one uses the /data endpoint
and the other uses the /asyncdata endpoint. The scripts ramp up to 500 active connections that
are submitting queries that take one second to complete. Once we have 500 connections running, we
create 50 additional connections that make synchronous requests with no delay.

# Requirements
`wrk` is required to run the benchmark scripts. A precompiled version of the benchmark code is available 
in the bin directory since since there are currently no jars available for sparkjava with async support.

# Running
To Run the benchmark:
* java -jar bin/async-benchmark-1.0.jar &
* sh bin/wrk_sync.sh
* \# wait a minute
* sh bin/wrk_async.sh

The results will be found in the files `/tmp/wrk_sync*` and `/tmp/wrk_async*`.

The benchmark application has the default 200 jetty threads available for processing requests 
and an additional 100 threads available for processing async requests. So you will typically
see that the synchronous endpoint has a higher throughput. If both thread pools were the same
size, the throughput would be similar.

The key finding in this benchmark is that async request processing frees up the jetty threads
to process requests so that long running requests to not impact the overall performance of the
server. 

# Sample Results
(run on an aging mac mini with one processor with two cores)

The output of the 50 synchrounous requests that are competing with 500 other synchronous connections:
```
Running 10s test @ http://localhost:4567/data
  5 threads and 50 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.82s   677.66ms   3.05s    53.20%
    Req/Sec    11.28     16.48    76.00     87.18%
  250 requests in 10.01s, 41.02KB read
  Socket errors: connect 0, read 13, write 0, timeout 0
Requests/sec:     24.98
Transfer/sec:      4.10KB
```
The output of the 50 synchrounous requests that are competing with 500 asynchronous connections:
```
Running 10s test @ http://localhost:4567/data
  5 threads and 50 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    13.29ms   33.70ms 280.34ms   90.85%
    Req/Sec     4.15k     3.41k   16.12k    73.77%
  188454 requests in 10.07s, 30.19MB read
Requests/sec:  18715.12
Transfer/sec:      3.00MB
```

So the throughput with async requests is 753x better and there were zero socket errors!

# Build
To rebuild the benchmark:
```
$ git clone https://github.com/joatmon/spark.git
$ cd spark
$ git checkout async-support
$ mvn install
$ cd ..
$ git clone https://github.com/joatmon/spark-async-benchmark.git
$ cd spark-async-benchmark
$ mvn package
$ mv target/async-benchmark-1.0.jar bin
```
