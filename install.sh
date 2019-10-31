#!/bin/bash

set -e

# Add the SDF public key and repository definition
# https://github.com/stellar/packages/blob/master/README.md
wget -qO - https://apt.stellar.org/SDF.asc | sudo apt-key add - && \
echo "deb https://apt.stellar.org/public stable/" | sudo tee -a /etc/apt/sources.list.d/SDF.list

# install latest Prometheus binary
wget https://github.com/prometheus/prometheus/releases/download/v2.13.1/prometheus-2.13.1.linux-amd64.tar.gz && \
sudo tar xvf prometheus-2.13.1.linux-amd64.tar.gz --strip-components=1 prometheus-2.13.1.linux-amd64/prometheus

# Add Grafana public key and repository definition
# https://grafana.com/docs/installation/debian/
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add - && \
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

# install quickstart
sudo apt-get update && \
sudo apt-get install -y  stellar-quickstart \
                         stellar-core-prometheus-exporter \
                         stellar-core-utils \
                         grafana \

# start prometheus
./prometheus --config.file=prometheus.yml &

# https://grafana.com/grafana/dashboards/10334
#rm /etc/apt/sources.list.d/SDF.list
