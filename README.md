# MongoDB Local ReplicaSet

This is docker image for creating mongodb replica set in yourlocal environment with authentication enabled (enforced to be precise). 
This docker image will create a self-contained 3 node replica set (that is, all three nodes are running in one container).
Important part is that replica set enforce authentication.

***Note: I know that all point of Docker is one process per container, but in this case I was unable to setup Mongodb replica set, with full authentication enabled in 3 or more Docker containers.***


***THIS IS ONLY USEFUL FOR LOCAL DEVELOPMENT***

## Using

You need to know the following:

#### LOGIN INFO

User info is configured on the admin database:

  - username: `dbadmin`
  - password: `adminPass`

#### PORTS
Each instance exposes a port, all listening on 0.0.0.0 interface:

  - db1: `27021` [primary]
  - db2: `27022`
  - db3: `27023`

#### DATA
The container will create one volume at `/data`, but you can mount one or more to your host at these paths:

  - db1: `/data/db1` [primary]
  - db2: `/data/db2`
  - db3: `/data/db3`

#### REPLICA SET NAME
It's called: `rs0`

## Notes

If you mount something into `/data/db1`, the container will not go through it's initialization process, but it will also assume that you have mounted all 3 volumes -- so mount all 3 or none.
You can customize the username/password by providing `USERNAME`/`PASSWORD` environment variables.

### Docker build command
```
docker build -t authdockermongo:1.0.1 .
```

### Example Run
Regular container start. Connect data folder from current directory. Change if you have your data somewhere else.
```
    docker run -p 27021:27021 -p 27022:27022 -p 27023:27023 -d --name autDockerMongo --network mongo10net --net-alias="authmongodocker.net" -v $(pwd)/data:/data authdockermongo:1.0.1
```

If you want to specify fixed IP address use next docker run command:
```
    docker run -p 27021:27021 -p 27022:27022 -p 27023:27023 -d --name autDockerMongo --network mongo10net --ip=192.168.44.101 --net-alias="authmongodocker.net" -v $(pwd)/data:/data authdockermongo:1.0.1
```

### Example Mongo Connection String (from localhost command line (your development machine))
```
    mongo -u dbadmin -p adminPass --authenticationDatabase admin mongodb://localhost:27021,localhost:27022,localhost:27023/dbTest?replicaSet=rs0
```
### Example Mongo Native Connection String (from node.js app on the host)
```
    mongodb://dbadmin:adminPass@localhost:27021,localhost:27022,localhost:27023/dream1dev3?replicaSet=rs0&authSource=admin
```
### Example Mongoose Connection String (from node.js app on the host)
```
    MONGO_URI=mongodb://dbadmin:adminPass@localhost:27021/dream1dev3,localhost:27022/dream1dev3,localhost:27023/dream1dev3?replicaSet=rs0&authSource=admin
```