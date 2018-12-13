#!/bin/bash

: ${RPXC_IMAGE:=vonamos/pi_compiler}

docker build -t $RPXC_IMAGE .
