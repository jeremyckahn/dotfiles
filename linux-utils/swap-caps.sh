#!/bin/bash
if gsettings get org.gnome.desktop.input-sources xkb-options | grep -q "caps:caps"
then
  gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"
else
  gsettings set org.gnome.desktop.input-sources xkb-options "['caps:caps']"
fi
