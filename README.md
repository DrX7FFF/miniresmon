# miniresmon
Mini shell for ressources monitoring in JSON format : 
* Local time
* Uptime
* CPU Load
* % RAM Free
* Temperature
* Partition list (fd -h)
  
Via shell script :
```
./miniresmon.sh
```

Via TCP socket


## Installation
Installation only shell script :
```
sh -c "$(curl https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/install.sh)"
```

Installation shell script + service (port par défaut 8889) :
```
sh -c "$(curl https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/install.sh) --service"
```

Installation shell script + service + port :
```
sh -c "$(curl https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/install.sh) --service 9999"
```

Uninstall :
```
sh -c "$(curl https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/install.sh) --uninstall"
```

## Copie dans le dossier courant
Installation only shell script :
```
curl -o https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/miniresmon.sh miniresmon.sh && chmod +x miniresmon.sh
```
