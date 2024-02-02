#!/bin/bash

if [ -z "$1" ]; then
   echo "Informe a rede alvo, exemplo: 172.16.1"
   echo "Necessário executar o script com permissões de usuário root"
   exit 1
else
   for ip in {53..58}; do
      echo "##> Testando IP $1.$ip"
      hping3 $1.$ip -S -c 1 -p 13 &> /dev/null
      hping3 $1.$ip -S -c 1 -p 37 &> /dev/null
      hping3 $1.$ip -S -c 1 -p 30000 &> /dev/null
      hping3 $1.$ip -S -c 1 -p 3000 &> /dev/null
      hping3 $1.$ip -S -c 1 -p 1337 2>/dev/null | grep "SA" &>/dev/null

      if [ $? -eq 0 ]; then
         curl "http://$1.$ip:1337/"
         break
      else
         echo "A porta 1337 não está aberta no IP $1.$ip"
      fi
   done
fi

exit 0
