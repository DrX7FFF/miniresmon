#!/bin/bash

SHELL_NAME="miniresmon.sh"
SERVICE_NAME="miniresmon.service"
REPO_URL="https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/$SHELL_NAME"
LOCAL_SCRIPT_PATH="/storage/.kodi/userdata/$SHELL_NAME"
SERVICE_FILE="/storage/.config/system.d/"$SERVICE_NAME

install_script() {
    echo "Téléchargement et installation du script..."
    curl -o "$LOCAL_SCRIPT_PATH" "$REPO_URL"
    chmod +x "$LOCAL_SCRIPT_PATH"
    echo "Script installé dans $LOCAL_SCRIPT_PATH"
}

create_service() {
    local port=${1:-8889}

    echo "Création du service systemd pour le script avec le port $port..."
    cat <<EOF >$SERVICE_FILE
[Unit]
Description=Disk Usage Script Service
After=network.target

[Service]
ExecStart=$LOCAL_SCRIPT_PATH -s $1
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

    if [ -f "$LOCAL_SCRIPT_PATH" ]; then
        rm -f "$LOCAL_SCRIPT_PATH"
        echo "Script supprimé de $LOCAL_SCRIPT_PATH"
    else
        echo "Script non trouvé à $LOCAL_SCRIPT_PATH"
    fi
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
