# SOAP2
This is a project for the SOA4ID course in the Computer Engineering carrer in the Tecnológico de Costa Rica.
In this project, a Kubernetes cluster is built, this cluster runs four microservices in different lenguajes. The lenguajes are
* NodeJS for the catalog and restaurants services
* Ruby for the user service
* Golang for the orders service
* Python for the reporting services

For the microservers written in Ruby and Golang GraphQL was used for running the CRUD operations.
This cluster also has two databases, one database in MySQL and the other in Neo4j.
All these services are running in Docker containers inside the cluster.

## Installation

### Docker

For the Docker installation, run the following command
```sh
sudo apt-get install docker.io
```

### Kubernetes
For the Kubernetes installing and cluster configuration, run in the master the following command
```
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
```
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

```
kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml
```

```
kubectl taint nodes --all node-role.kubernetes.io/master-
```

### Microservices

#### NodeJS
For configure and run NodeJS in your local machine, run the following command
```
sudo apt-get install nodejs npm
```

### Ruby
For configure and run Ruby in your local machine, run the following command
```
sudo apt install ruby-full 
```

In this project, Ruby on Rails was used because of its easy configuration for running a RESTApi, to install it, run the following command
```
gem install rails
```
### Golang
For configure and run Golang in your local machine, run the following command
```
wget https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz
sudo tar -xvf go1.13.1.linux-amd64.tar.gz
sudo mv go /usr/local
```

### Python 
For configure and run Python in your local machine, run the following command
```
sudo apt-get install python
sudo apt install python3-pip
```
In this project, the framework Flask was used because of its easy configuration for running a RESTApi, to install it, run the following command
```
pip install flask
```

## References
In order to have a better understanding of the previous topics, you can visit the following links
* https://tecadmin.net/install-go-on-ubuntu
* https://linuxize.com/post/how-to-install-ruby-on-ubuntu-18-04/
* https://docs.projectcalico.org/v3.10/getting-started/kubernetes

## Release History
* 1.0.0
  * Add the complete full working project
