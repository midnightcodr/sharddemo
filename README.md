# About
This is a do-it-all docker-compose setup that's based on [this awesome tuturial on Mongodb sharding](https://www.youtube.com/watch?v=Rwg26U0Zs1o). Unlike the tutorial, all the steps that require to be run manually (like adding shards to the router server, inserting documents to the movies collection) are all taken care of by one single init script (which runs only once of course). If you find any issues using this demo. Please feel free to create an issue. Enjoy!

The `/scripts/wait` program is from [https://github.com/ufoscout/docker-compose-wait](https://github.com/ufoscout/docker-compose-wait) in case you are curious.


# Setup
```bash
mkdir -p ~/docker-storage/sharddemo/{dummy,router1,router2,cfg1p,cfg1s1,cfg1s2,shrd1p,shrd1s1,shrd1s2,shrd2p,shrd2s1,shrd2s2}
```

# Run
```bash
docker-compose up
```

# Test
In a separate terminal, run
```bash
docker exec -it sharddemo_router1_1 /bin/bash
mongo
```

Once in mongo console,

```javascript
sh.status()
use sharddemo
db.movies.getShardDistribution()
```

# Need to start all over? No problem
```bash
docker-compose down
rm -rf ~/docker-storage/sharddemo
```
then start allover from step Setup above.