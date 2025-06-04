#!/bin/bash

DOMAIN_LIST="domains.txt"
WORDLIST="/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt"
TIME_LIMIT=5
THREADS=150

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

printf "${CYAN}%-35s %-10s${RESET}\n" "Domain" "RPS (req/sec)"
printf "${CYAN}%-35s %-10s${RESET}\n" "-----------------------------------" "----------"

while read -r domain; do
  [ -z "$domain" ] && continue

  [[ "$domain" != http* ]] && domain="https://$domain"

  tmpfile=$(mktemp)

  start_time=$(date +%s)
  timeout ${TIME_LIMIT}s feroxbuster -u "$domain" \
    -w "$WORDLIST" -A -k -t $THREADS -C 404,403,400 --no-recursion \
    --json > "$tmpfile" 2>/dev/null
  end_time=$(date +%s)

  duration=$((end_time - start_time))
  [[ "$duration" -eq 0 ]] && duration=1

  # Ferox'un JSON çıktısında her isabet bir JSON objesidir.
  # Bunları sayarak toplam yanıtlanan istek sayısını bulabiliriz.
  count=$(grep -c '"url"' "$tmpfile")
  rps=$((count / duration))

  printf "${YELLOW}%-35s${GREEN} %-10s${RESET}\n" "$domain" "$rps"

  rm "$tmpfile"
done < "$DOMAIN_LIST"
