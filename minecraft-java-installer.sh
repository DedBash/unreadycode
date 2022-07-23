### Intro ###
echo -e "******************************"
echo -e "* Minecraft Server Installer *"
echo -e "*    By Kiznaiver System     *"
echo -e "******************************"
### variable ###
progress_bar='▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒'
cursor_on='tput cnorm'
cursor_off='tput civis'

### Minecraft Select ###
select_minecraft(){
    echo "test"
}

#### Java Install ####
### Java repuired ###
java_required(){
    if grep -rhE http://ppa.launchpad.net/openjdk-r/ppa/ubuntu /etc/apt/sources.list* 1>/dev/null 2>/dev/null; then
        echo -e "Everything necessary is installed"
    else
        echo -e "Not everything necessary is installed"
        echo -e "Setup ppa openjdk"
        ${cursor_off}
        for i in `seq 1 100`; do
            printf "\033[s\033[u Progress: %s %3d %% \033[u" "${progress_bar:0:$(((i+1)/2))}" "$i"
            add-apt-repository ppa:openjdk-r/ppa -y 1>/dev/null 2>/dev/null
            apt update -y 1>/dev/null 2>/dev/null
        done
        ${cursor_on}
    fi
}

### Install Java 8 ###
java_8_install(){
    if dpkg-query -s openjdk-8-jre 1>/dev/null 2>/dev/null; then
        echo -e "Java 8 is already installed"
    else
        echo -e "Install Java 8 jre"
        ${cursor_off}
        for i in `seq 1 100`; do 
            printf "\033[s\033[u Progress: %s %3d %% \033[u" "${progress_bar:0:$(((i+1)/2))}" "$i"
            apt-get install openjdk-8-jre 1>/dev/null 2>/dev/null
        done
        ${cursor_on}
    fi
}

### Install Java 16 ###
java_16_install(){
    if dpkg-query -s openjdk-16-jre 1>/dev/null 2>/dev/null; then
        echo -e "Java 16 is already installed"
    else
        echo -e "Install Java 16 jre"
        ${cursor_off}
        for i in `seq 1 100`; do 
            printf "\033[s\033[u Progress: %s %3d %% \033[u" "${progress_bar:0:$(((i+1)/2))}" "$i"
            apt-get install openjdk-16-jre 1>/dev/null 2>/dev/null
        done
        ${cursor_on}
    fi
}


### Java Select ###
select_java(){
    if [ "$EUID" -ne 0 ]
    then 
        echo "Please run as root or sudo"
        exit
    else
        while true; do
        echo ""
        read -p "> " javaselect
        case $javaselect in
            1 ) select_minecraft; exit;;
            2 ) java_required; select_java; exit;;
            * ) echo "Please answer 1, 2, 3 or 4.";;
        esac
    done
    fi
}

### Frist after run / Start Selector ###
select_start(){
    while true; do
        echo ""
        read -p "> " startselect
        case $startselect in
            1 ) select_minecraft; exit;;
            2 ) select_java; exit;;
            * ) echo "Please answer 1, 2, 3 or 4.";;
        esac
    done
}

### command variable ###
case $1 in
    --minecraft ) select_minecraft; exit;;
    --java) select_java; exit;;
    --help) ;;
    * ) select_start;;
esac
