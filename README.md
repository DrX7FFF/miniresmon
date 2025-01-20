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
./install.sh
```

Installation shell script + service (port par défaut 8889) :
```
./install.sh --service
```

Installation shell script + service + port :
```
./install.sh --service 9999
```

Uninstall :
```
./install.sh --uninstall
```
