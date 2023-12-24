# homelab

## Asus router
Access via https://router.asus.com.

## How DNS works
We use pihole running on a raspberrypi 3B connected via `eth` to the router. This is used so that we can use domain names to point to devices in the local network. You can view the DNS records in the [pi-hole admin panel](http://pi.hole/admin).

_Password stored in firefox._

Note: we are not using pi-hole as a DHCP server. We leave this to the router, although we should likely use the pi-hole server for this.

## Discoveries
1. Do not have a secondary DNS server in router config. This makes pi-hole local DNS not work.
2. Do not use `.local` for domain in local DNS. You will see a warning when using dig that `.local` is reserved for mDNS.

_NOTE: you will notice that ports are abnormal. This is because Cox won't allow opening port 80 and 443 on residential routers. Check router.asus.com port forwarding settings to see where services live._

## Container registry
For saving docker images. We run a private registry.

Use `docker login registry.flowy.live:5443`

_Ask Arjun to add another user for you._
username: talksik
password: (it's typical arjun)

Used [this](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-20-04) guide to get a private docker registry running, in docker.

Given that the reverse-proxy works and domain works, hitting `https://registry.flowy.live:5443/v2/_catalog` and entering credentials should return list of repositories.

## Reverse-proxy
We run our reverse-proxy on homelab1 or talksik-homelab-main.

The current configuration is at `talksik@homelab1.home:/etc/nginx/nginx.conf` as one would expect. However, we have a (likely stale) copy in `./reverse-proxy`.

Update by doing the following:
```sh
set -e
set -o pipefail

sudo nginx -t
sudo service nginx restart
```

## Kubernetes
Using k3s. Lightweight, easy system service.

Make sure you have static ip for each node.

### Grafana and prometheus
Using this guide: https://k21academy.com/docker-kubernetes/prometheus-grafana-monitoring/


## SSL Certificates
The way it all works in baby terms is that you tell your DNS server like domains.google.com to use an a record for your domain to go to an IP address.

Then, presuming you have a nginx server running and portforwarding works, certbot will hit your domain (say `flowy.live`), and make sure that it hit this current server (or something like that).

And then, it generates a certificate with a certificate authority and installs in some folder within the linux computer.

Then you point to that ssl certificate in nginx config for different endpoints.

run a cronjob on the system that runs the nginx server as mentioned [here](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/) to auto-renew certificate(s) when they are about to expire.
