#!/bin/bash
echo "===let's wait==="
/scripts/wait
echo "Waiting for cfg1p to become ready.."
until mongo --host cfg1p --eval 'rs.status().ok' &>/dev/null; do
  echo 'wait for cfg1p'
  sleep 1
done

echo "Waiting for shrd1p to become ready.."
until mongo --host shrd1p --eval 'rs.status().ok' &>/dev/null; do
  echo 'wait for shrd1p'
  sleep 1
done
echo 'sh.addShard("shrd1/shrd1p,shrd1s1,shrd1s2")' | mongo --host router1
echo "Waiting for shrd2p to become ready.."
until mongo --host shrd2p --eval 'rs.status().ok' &>/dev/null; do
  echo 'wait for shrd2p'
  sleep 1
done
sleep 5
echo 'sh.addShard("shrd2/shrd2p,shrd2s1,shrd2s2")' | mongo --host router1
echo -e "use sharddemo\n sh.enableSharding('sharddemo')\n sh.shardCollection('sharddemo.movies', {title: 'hashed'})" | mongo --host router1
for i in {1..50}; do echo -e "use sharddemo\n db.movies.insertOne({title: \"Mongo sharding demo $i\", language: 'English'})" | mongo --host router1; done
echo "all done" > /tmp/debug.log