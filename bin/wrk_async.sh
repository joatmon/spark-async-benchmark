wrk -t5 -c50 -d60s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async1 &
sleep 5
wrk -t5 -c50 -d55s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async2 &
sleep 5
wrk -t5 -c50 -d50s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async3 &
sleep 5
wrk -t5 -c50 -d45s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async4 &
sleep 5
wrk -t5 -c50 -d40s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async5 &
sleep 5
wrk -t5 -c50 -d35s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async6 &
sleep 5
wrk -t5 -c50 -d30s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async7 &
sleep 5
wrk -t5 -c50 -d25s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async8 &
sleep 5
wrk -t5 -c50 -d20s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async9 &
sleep 5
wrk -t5 -c50 -d15s --timeout 30s http://localhost:4567/asyncdata?delay=1000 > /tmp/wrk_async10 &
wrk -t5 -c50 -d10s --timeout 30s http://localhost:4567/data > /tmp/wrk_async_nodelay
