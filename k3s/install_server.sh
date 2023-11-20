#!/bin/bash

# servicelb disabled so that metallb can work
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=servicelb --cluster-init" sh -
