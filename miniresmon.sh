#!/bin/sh

# Fonction pour construire le JSON
build_json() {
    awk \
    -v meminfo="$(free | grep "^Mem:")" \
    -v uptime="$(cat /proc/uptime)" \
    -v temperature="$(cat /sys/class/thermal/thermal_zone0/temp)" \
    -v loadavg="$(cat /proc/loadavg)" \
    -v dfinfo="$(df -h | grep "^/dev/")" \
    -v dpart="$(for part in /sys/class/block/*; do if [ -e "$part/partition" ]; then device="/dev/$(basename "$part")"; echo $device; fi; done)" \
    -v blkidlabel="$(for symlink in /dev/disk/by-label/*; do echo "$(readlink -f "$symlink") $(basename "$symlink")"; done)" \
    'BEGIN {
        printf "{\"timestamp\": " strftime("%s") "000, "

        split(uptime, uptimeF)
        printf "\"uptimeRAW\": %d, \"uptime\": \"%dj %dh %dm\", ", uptimeF[1], uptimeF[1]/86400, (uptimeF[1]%86400)/3600, (uptimeF[1]%3600)/60

        printf "\"temperature\": %.1f, ", temperature/1000

        split(loadavg, loadavgF)
        split(meminfo, meminfoF)
        printf "\"load\": {\"avg1\": %s, \"avg5\": %s, \"avg15\": %s, \"memory\": %.2f}, ", loadavgF[1], loadavgF[2], loadavgF[3], meminfoF[3]/meminfoF[2]

        # Liste des Labels des partitions
        split (blkidlabel, blkidlabelL, "\n")
        for(i in blkidlabelL){
            split (blkidlabelL[i], blkidlabelF)
            blkname[blkidlabelF[1]] = blkidlabelF[2]
        }
        # Liste des partitions
        split (dpart, dpartL, "\n")

        split (dfinfo, dfinfoL, "\n")
        sep = ""
        printf "\"disks\": ["
        for (j in dpartL){
            for(i in dfinfoL){
                split (dfinfoL[i], dfinfoF)
                if (dpartL[j] == dfinfoF[1]) {
                    printf "%s{\"device\": \"%s\", \"label\": \"%s\", \"size\": \"%s\", \"used\": \"%s\", \"avail\": \"%s\", \"perc\": \"%s\"}", sep, dfinfoF[1], blkname[dfinfoF[1]], dfinfoF[2], dfinfoF[3], dfinfoF[4], dfinfoF[5]
                    sep = ","
                    break
                }
            }
        }
        print "]}"
    }'
}

# Mode serveur
start_server() {
    local port=$1
    nc -lk -p "$port" -e sh -c "$(declare -f build_json); build_json"
}

# Détection du mode
if [ "$1" = "-s" ]; then
    port=${2:-8889} # Défaut : 9999 si aucun port spécifié
    echo "Mode serveur actif sur le port $port..."
    start_server "$port"
else
    # Mode direct
    build_json
fi