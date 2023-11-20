# homelab

## Asus router
Access via https://router.asus.com.

## How DNS works
We use pihole running on a raspberrypi 3B connected via `eth` to the router. This is used so that we can use domain names to point to devices in the local network. You can view the DNS records in the [pi-hole admin panel](http://pi.hole/admin).

_Password stored in firefox._

Note: we are not using pi-hole as a DHCP server. We leave this to the router, although we should likely use the pi-hole server for this.

### Discoveries
1. Do not have a secondary DNS server in router config. This makes pi-hole local DNS not work.
2. Do not use `.local` for domain in local DNS. You will see a warning when using dig that `.local` is reserved for mDNS.

## Container registry
For saving docker images. We run a private registry.

_Ask Arjun to add another user for you._
username: talksik
password: (it's typical arjun)

Used [this](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-20-04) guide to get a private docker registry running, in docker.

Given that the reverse-proxy works and domain works, hitting `https://registry.flowy.live/v2/_catalog` and entering credentials should return list of repositories.

## Reverse-proxy
We run our reverse-proxy on homelab1 or talksik-homelab-main.

The current configuration is at `talksik@homelab1.home:/etc/nginx/nginx.conf` as one would expect. However, we have a (likely stale) copy in `./reverse-proxy`.

## Kubernetes
Using k3s. Lightweight, easy system service.

Make sure you have static ip for each node.
