#!/usr/bin/expect -f

lassign $argv ip user password keypath

set timeout 15

spawn ssh-copy-id \
    -f \
    -i "${keypath}" \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -o ConnectTimeout=5s \
    -o PreferredAuthentications=password \
    "${user}@${ip}"

expect {
    -re ".*assword:.*" {
        send "$password\r"
        exp_continue
    }

    -re ".*ERROR.*" {
        exit 1
    }

    eof {}
}