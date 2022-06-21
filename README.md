# OSMT Wrapper
This is a configuration management mini-system for the [Open Skills Management Tool (OSMT)](https://github.com/wgu-opensource/osmt). Follow the below steps to get a basic instance of OSMT running in production.

Steps vary slightly between different cloud service providers, but the general ideas are the same. Let's work together and update this repository with additional guides and pointers.

## Deploying OSMT to Digital Ocean
This approach results in a basic "droplet" running OSMT, and Redis, with an Nginx reverse proxy and Let's Encrypt SSL certificate. It depends on a managed MySQL database and a separate managed or self-hosted Elasticsearch service. Commands below are as they appear on a MacOS or (most) Linux local machines.

1. Clone osmt-wrapper Docker Compose-based production configuration tool​ to your computer (this repository)
2. Create resources (Digital Ocean droplets and database service)​
3. Register & configure domain name (or configure DNS for subdomain for a domain you own). [How to configure DNS at your registrar](https://docs.digitalocean.com/tutorials/dns-registrars/) and [How to configure domain for the droplet at Digital Ocean](https://docs.digitalocean.com/products/networking/dns/quickstart/)
4. Configure SSH access to droplets​. I created a HostName alias `osmt1` in my `~/.ssh/config` file for SSH-based (not password) access to the OSMT droplet.
5. Install and configure Elasticsearch (and protect it with firewall)​. See [Guide](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-ubuntu-20-04) to set up Elasticsearch on a Digital Ocean Ubuntu droplet. (Make sure you select enough CPU and RAM for your droplet.)
6. Sign up for [Okta developer account](https://developer.okta.com/signup/) for authentication, configure as per guide in the [OSMT Readme](https://github.com/wgu-opensource/osmt/blob/develop/README.md#oauth2-and-okta-configuration).
7. Fill out environment settings. `cp osmt-prod.env.example osmt-prod.env` and customize with your Domain, MySQL DB and Elasticsearch information. Copy white label configuration `cp ./whitelabel/whitelabel.example.json ./whitelabel/whitelabel.json` and customize with strings describing your service.
8. Sync osmt-wrapper to production droplet​: execute `./bin/sync.sh` to copy contents of this directory to `/opt/osmt-wrapper`
9. Start service on production droplet. SSH to osmt1 (`ssh osmt1`), navigate to `/opt/osmt-wrapper` and execute `./bin/start.sh` to run the Docker Compose service.
10. Add a [Firewall](https://cloud.digitalocean.com/networking/firewalls/new) to leave open only ports 443, 80 to traffic from anywhere. Restrict port 22 (SSH) to your IP address(es).

## Using the wrapper locally
You may customize `osmt-dev.env` to run the stack locally in a similar fashion to the quickstart in the main OSMT repository, including the database and Elasticsearch locally using Docker Compose.
