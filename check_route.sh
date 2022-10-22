#!/bin/bash

#Paramter
iface1=eth01
iface2=wwan0
iface3=wlan0

#Pruefen ob die Datei /root/WAN_WEG_VAR existiert
var_exist=/tmp/wan_weg_var.txt
if test -f "$var_exist"; then
true
#echo "$var_exist exists."
else
echo "$var_exist existiert nicht - Datei wird angelegt"
touch $var_exist
fi


#Aktuellen WAN-Weg einlesen
WAN_WEG=$(route | sed -e '4,$d' | sed -e '1,2d' | awk '{print $8}')

#Letzten Wert von WAN_WEG_VAR aus Datei einlesen
WAN_WEG_VAR=$(cat /tmp/wan_weg_var.txt)
#echo "Inhalt WAN_WEG_VAR: $WAN_WEG_VAR"
#echo "Inhalt WAN_WEG: $WAN_WEG"

#Aktuellen WAN-WEG mit letztem, gespeicherten WAN-WEG vergleichen
if [ "$WAN_WEG" == "$WAN_WEG_VAR" ]; then
   true
   echo "Aktueller WAN-Weg: $WAN_WEG - Lezter gespeicherter WAN-Weg: $WAN_WEG_VAR - Keine Aenderung"
else
   echo "WAN-Weg Aenderung Neu: $WAN_WEG Alt: $WAN_WEG_VAR - Schreibe WAN_WEG_VAR neu"
   echo $WAN_WEG > /tmp/wan_weg_var.txt
   #WAN_WEG_VAR=$(cat /tmp/wan_weg_var.txt)
   if [ "$WAN_WEG" == "§iface1" ]; then
      echo "WAN-WEG AENDERUNG: Aktueller WAN-Weg: $WAN_WEG - Letzter WAN-Weg: $WAN_WEG_VAR"
      logger -p syslog.info -t WAN-MESSAGE "WAN-WEG AENDERUNG: Aktueller WAN-Weg: $WAN_WEG - Letzter WAN-Weg: $WAN_WEG_VAR"
   elif [ "$WAN_WEG" == "$iface2" ]; then
      echo "WAN-WEG AENDERUNG: Aktueller WAN-Weg: $WAN_WEG - Letzter WAN-Weg: $WAN_WEG_VAR"
      logger -p syslog.info -t WAN-MESSAGE "WAN-WEG AENDERUNG: Aktueller WAN-Weg: $WAN_WEG - Letzter WAN-Weg: $WAN_WEG_VAR"
   elif [ "$WAN_WEG" == "$iface3" ]; then
      echo "WAN-WEG AENDERUNG: Aktueller WAN-Weg: $WAN_WEG - Letzter WAN-Weg: $WAN_WEG_VAR"
      logger -p syslog.info -t WAN-MESSAGE "WAN-WEG AENDERUNG: Aktueller WAN-Weg: $WAN_WEG - Letzter WAN-Weg: $WAN_WEG_VAR"
   elif [ "$WAN_WEG" != "§iface1" ] || [ "$WAN_WEG" != "§iface2" ] || [ "$WAN_WEG" != "§iface3" ]; then
      echo "WAN-WEG AENDERUNG: Aktueller WAN-Weg: $WAN_WEG - Letzter WAN-Weg: $WAN_WEG_VAR"
      logger -p syslog.info -t WAN-MESSAGE "WAN-WEG AENDERUNG: Aktueller WAN-Weg: $WAN_WEG - Letzter WAN-Weg: $WAN_WEG_VAR"
   fi
fi