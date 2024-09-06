# VPN-HELPER

A small container that will help you access services located on remote
VPN clients. The main idea of this repository is to forward ports from
VPN network clients to the network of the container itself, as a result
of which users access the container ports directly without going into
details of the VPN server and client network device, which allows you
to directly open ports to the host or use it in conjunction with proxy
servers (such as NGINX Reverse Proxy, Caddy, etc.).

## Configuring

* Replace docker network name with your VPN server network, including
  changing the environment variable `$VPN_HELPER_VPN_SERVER_NETWORK`,
  as an example, a network named `vpn_net` is used. Also set the name
  of the container in which we will launch the VPN server, as an
  example, `openvpn` is used.

  ```
  services:
    vpn-helper:
      environment:
        - VPN_HELPER_VPN_DOCKER_NETWORK_NAME=openvpn.vpn_net
      networks:
        - vpn_net
  
  networks:
    vpn_net:
      external: true
  ```
* Specify the subnet of the VPN server in the environment variables
  `$VPN_HELPER_VPN_SERVER_NETWORK`, by default `192.168.255.0/24`

  ```
  VPN_HELPER_VPN_SERVER_NETWORK=192.168.255.0/24
  ```

* Specify your port forwarding rules in the environment variable
  `$VPN_HELPER_FORWARDING_RULES`, the rules look like
  `8082:192.168.255.2:8081`, where:
  * 8082 - destination port;
  * 192.168.255.2 - IP address of the VPN client where the remote
    service is located; 
  * 8081 - port the remote service is listening on.
  
  You can specify several rules at once, for example:
  ```
  VPN_HELPER_FORWARDING_RULES=
    8082:192.168.255.2:8081
    8083:192.168.255.2:8082
  ```
