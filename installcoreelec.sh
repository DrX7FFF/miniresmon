#!/bin/bash

SCRIPT_NAME="miniresmon.sh"
SERVICE_NAME="miniresmon.service"
SCRIPT_FILE="/storage/.kodi/userdata/$SCRIPT_NAME"
SERVICE_FILE="/storage/.config/system.d/"$SERVICE_NAME
REPO_URL="https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/$SCRIPT_NAME"

install_script() {
    echo "Téléchargement et installation du script..."
    curl -o "$SCRIPT_FILE" "$REPO_URL"
    chmod +x "$SCRIPT_FILE"
    echo "Script installé dans $SCRIPT_FILE"
}

create_service() {
    local port=${1:-8889}

    echo "Création du service systemd pour le script avec le port $port..."
    cat <<EOF >$SERVICE_FILE
[Unit]
Description=Disk Usage Script Service
After=network.target

[Service]
ExecStart=$SCRIPT_FILE -s $1
Restart=always
User=$(whoami)

[Install]
WantedBy=multi-user.target
EOF

    echo "Service créé. Activation et démarrage du service..."
    systemctl daemon-reload
    systemctl enable "$SERVICE_NAME"
    systemctl start "$SERVICE_NAME"
    echo "Service $SERVICE_NAME actif sur le port $port"
}

uninstall() {
    echo "Suppression du script et du service..."
    systemctl stop "$SERVICE_NAME"
    systemctl disable "$SERVICE_NAME"
    rm -f SERVICE_FILE
    systemctl daemon-reload
    echo "Service $SERVICE_NAME supprimé"

    rm -f "$SCRIPT_FILE"
}

main() {
    echo "Version 4"
    echo "Mode : $1"
    case "$1" in
        --uninstall)
            uninstall
            ;;
        --service)
            install_script
            create_service "$2"
            ;;
        *)
            install_script
            ;;
    esac
}

main "$@"
