#!/bin/bash

case "$1" in
    "dev1"|"dev-agent01")
        xfreerdp /v:13.58.30.31:3389 /u:Administrator /p:'5d6&M;*SARr-Wuq%ifHc(DdgkO-&nZl@' /cert-ignore /size:1280x720 &
        ;;
    "dev2"|"dev-agent02")
        xfreerdp /v:3.14.230.52:3389 /u:Administrator /p:'YBwbrb%8d9*zXQ9AKQ9wNfvo96t&Y.sK' /cert-ignore /size:1280x720 &
        ;;
    "sales"|"sales-agent01")
        xfreerdp /v:3.19.80.124:3389 /u:Administrator /p:'vaRgzhZ5pbl5-4!7VjJCtuIM4)FRIpjj' /cert-ignore /size:1280x720 &
        ;;
    *)
        echo "Usage: $0 {dev1|dev2|sales}"
        echo "  dev1  - Connect to Dev-Opnova-Agent01 (13.58.30.31)"
        echo "  dev2  - Connect to Dev-Opnova-Agent02 (3.14.230.52)"
        echo "  sales - Connect to Sales-Opnova-Agent01 (3.19.80.124)"
        ;;
esac
