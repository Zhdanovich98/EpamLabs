### Task 7: "Monitoring, Log collection" ###
#### 7.1 Collectd, Influxdb, Grafana: ####
This task is done using docker-compose, it includes 3 containers ([collectd](https://hub.docker.com/r/fr3nd/collectd), [influxdb](https://hub.docker.com/_/influxdb), [grafana](https://hub.docker.com/r/grafana/grafana)).
##### To start the monitoring stack run: ##### 
```sh
docker-compose up
```
Verify the deployment by navigating to your server address in
your preferred browser.
```sh
 127.0.0.1:3000
```
> *collectd.conf - modified default config file that tells collectd to send data to a remote server that uses address 127.0.0.1 and port 25826.*
> 
> *influxdb.conf - modified default config file so that influxdb can receive collected data from collectd.*
>
> *types.db - this is the file that defines the collectd data source specification, and influxdb needs this file to understand collectd’s data.*
---
#### 7.2 Elasticsearch, Logstash, Kibana, Filebeat: ####
This task is done using docker-compose, it includes 4 containers ([elasticsearch](https://hub.docker.com/_/elasticsearch), [logstash](https://hub.docker.com/_/logstash), [kibana](https://hub.docker.com/_/kibana) [filebeat](https://hub.docker.com/_/filebeat/plans/6656606a-73e9-4a5c-bab5-dfdd147a9f18?tab=instructions)).
##### To start the monitoring stack run: ##### 
```sh
. .env
```
```sh
docker-compose up
```
Verify the deployment by navigating to your server address in
your preferred browser.
```sh
 127.0.0.1:5601
```
> */filebeat/config/filebeat.docker.yml - file containing configuration for Filebeat.*
> 
> */nginx/log/*.log - example directory on host with log files.*
> 
> */logstash/pipeline/nginx.conf -  file configuration for Logstash*
---
