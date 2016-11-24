#!/bin/bash

remserial -r $NXUSERIP -p 7200 -l ~/.wine/dosdevices/com1 /dev/ptmx

read r
