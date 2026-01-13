#!/bin/bash
verifica_ip() {
    local nume=$1
    local ip_local=$2
    local dns_server=$3
    local real_ip=$(nslookup "$nume" "$dns_server" 2>/dev/null | grep '^Address:' | tail -n1 | awk '{print $2}')
    if [[ -n "$real_ip" && "$real_ip" != "$ip_local" ]]; then
        echo "Bogus IP for $nume in /etc/hosts! (DNS $dns_server returned $real_ip)"
    fi
}

DNS_EXTERN="8.8.8.8"

cat /etc/hosts | while read -r ip nume rest; do
    if [[ -z "$ip" || "$ip" == "#"* ]]; then
        continue
    fi
    verifica_ip "$nume" "$ip" "$DNS_EXTERN"

done
echo "Neacsa Bogdan"
