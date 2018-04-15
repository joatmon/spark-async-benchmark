wrk -t5 -c50 -d60s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync1 &
sleep 5
wrk -t5 -c50 -d55s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync2 &
sleep 5
wrk -t5 -c50 -d50s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync3 &
sleep 5
wrk -t5 -c50 -d45s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync4 &
sleep 5
wrk -t5 -c50 -d40s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync5 &
sleep 5
wrk -t5 -c50 -d35s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync6 &
sleep 5
wrk -t5 -c50 -d30s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync7 &
sleep 5
wrk -t5 -c50 -d25s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync8 &
sleep 5
wrk -t5 -c50 -d20s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync9 &
sleep 5
wrk -t5 -c50 -d15s --timeout 30s http://localhost:4567/data?delay=1000 > /tmp/wrk_sync10 &
wrk -t5 -c50 -d10s --timeout 30s http://localhost:4567/data > /tmp/wrk_sync_nodelay &
