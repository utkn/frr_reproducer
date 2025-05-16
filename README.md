# FRR bug reproducer

## Setup

To setup the containers run the following command:

```bash
docker-compose -f $PWD/docker-compose.yml up -d
```

## Topology

We have 2 frr containers (frr2 and frr3) connected to each other. One frr_test container is using the same network as frr2 it generates routes.

```text
+------------+                               +------------+
|    frr2    |-- 10.0.0.2 ------- 10.0.0.3 --|    frr3    |
+------------+                               +------------+
       |
+------------+
|  frr_test  |
+------------+
```

## Triggering the bug

```shell
# setup the topology:
docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml up -d

# inject some routes
docker exec frr2 bash -c "wget -q 10.42.0.2:80/add -O -"

# watch the received routes on frr3 (in another terminal)
watch "docker exec -it frr3 vtysh -c 'show ip route summary'"

# once frr3 shows all routes (1000) run a sequence of removals and additions
docker exec frr2 bash -c "wget -q 10.42.0.2:80/sequence -O -"

# continue to wathch the routes on frr3 it will not show all 1000 again after the above sequence has completed
#

# check the logs
docker cp frr2:/tmp/frr.log .
grep supress frr.log

# teardown
docker-compose -f docker-compose.yml down -v


# remove the `!` on the line `! no bgp suppress-duplicates` in frr2.conf and try again. All routes will be there.
```
