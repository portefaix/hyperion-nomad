# Hyperion

[![License Apache 2][badge-license]][LICENSE][]
![Version][badge-release]

## Description

[hyperion][] creates a Cloud environment :

- Identical machine images creation is performed using [Packer][]
- Orchestrated provisioning is performed using [Terraform][]
- Applications managment is performed using [Nomad][]

## Nomad


## Local

Initialize environment:

    $ make init


## Cloud

### Images

Read guides to creates the machine for a cloud provider :

* [Google cloud](https://github.com/portefaix/hyperion-nomad/blob/packer/google/README.md)
* [AWS](https://github.com/portefaix/hyperion-nomad/blob/packer/ec2/README.md)
* [Digitalocean](https://github.com/portefaix/hyperion-nomad/blob/packer/digitalocean/README.md)

### Infratructure

Read guides to creates the infrastructure :

* [Google cloud](https://github.com/portefaix/hyperion-nomad/blob/infra/google/README.md)
* [AWS](https://github.com/portefaix/hyperion-nomad/blob/infra/aws/README.md)
* [Digitalocean](https://github.com/portefaix/hyperion-nomad/blob/infra/digitalocean/README.md)
* [Openstack](https://github.com/portefaix/hyperion-nomad/blob/infra/openstack/README.md)


## Usage

* Start Nomad on the nodes, specifying the address of eth0 to bind to.

        $ sudo nomad agent -config server.hcl -bind=10.33.23.4

* Join the nodes, from one of the nodes, connect to the others :

        $ nomad server-join -address http://$SERVER:4646 $MYADDRESS


## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).


## License

See [LICENSE][] for the complete license.


## Changelog

A [changelog](ChangeLog.md) is available


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>


[hyperion]: https://github.com/portefaix/hyperion-nomad
[LICENSE]: https://github.com/portefaix/hyperion-nomad/blob/master/LICENSE
[Issue tracker]: https://github.com/portefaix/hyperion-nomad/issues

[nomad]: https://www.nomadproject.io/
[terraform]: https://terraform.io
[packer]: https://packer.io

[badge-license]: https://img.shields.io/badge/license-Apache_2-green.svg
[badge-release]: https://img.shields.io/github/release/portefaix/hyperion-nomad.svg
