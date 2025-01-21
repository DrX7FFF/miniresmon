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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/install.sh)"
```

Installation shell script + service (port par défaut 8889) :
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/install.sh) --service"
```

Installation shell script + service + port :
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/install.sh) --service 9999"
```

Uninstall :
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/install.sh) --uninstall"
```

## Installation Coreelec
Installation only shell script :
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/installcoreelec.sh)"
```

Installation shell script + service (port par défaut 8889) :
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/installcoreelec.sh) --service"
```

Installation shell script + service + port :
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/installcoreelec.sh) --service 9999"
```

Uninstall :
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DrX7FFF/miniresmon/main/installcoreelec.sh) --uninstall"
```
