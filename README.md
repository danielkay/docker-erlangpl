# Dockerised Erlangpl Instance
This repo provides an instance of [Erlangpl](https://github.com/erlanglab/erlangpl) which runs as a sidecar container to
a containerised Erlang BEAM project running in the [docker-stack](https://github.com/danielkay/docker-stack) network. It
uses a container network mount to connect directly to `epmd` in the development container and begin monitoring BEAM
nodes in the remote ErlangVM.

### Monitoring an ErlangVM node
To successfully launch the Erlangpl container you must first ensure that your Erlang development container has been
configured correctly to allow for a connection:
- as explained in the
[Erlangpl documentation](https://github.com/erlanglab/erlangpl#3-run-the-script) you must launch your ErlangVM node in
distributed mode, and you must ensure that the cookies assigned to your node and to Erlangpl match;
- use provided the `make up` Makefile task to launch an Erlangpl container, providing the APP_NAME and ERLANG_CONTAINER
environment variables in order to connect to the relevant container and erlang node.