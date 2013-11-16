#!/bin/bash

case "$(xset -q|grep LED| awk '{ print $10 }')" in
  "00000000") KBD="en" ;;
  *) KBD="ru" ;;
esac

echo $KBD