## TO INSTALL
    sudo apt install git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" #OH MY ZSH
    sudo apt install fzf
    sudo apt install stow

## HOW TO USE 

stow permette di creare ricorsivamente symbolic link di tutti file e directories, presenti nella directory specificata, all'interno della directory padre.
Affinche' non vada a creare symbolic link per anche le carte e' importante creare manualmente le directory .config e .config/custom

sudo apt install stow

mkdir .config
mkdir .config/custom
mkdir .config/custom/starting_scripts

stow ./

## FIXES

Nel caso in cui manchino dei simboli in nvim bisogna installare dei nerd fonts, da questo link:
    https://www.nerdfonts.com/font-downloads

_ Una volta scaricato basta unzippare e spostare l'intera directory in /usr/share/fonts/
_ Selezionare il font le impostazioni del terminale

# MASON

    In caso di errore nel download eseguire :MasonInstall [lsp-server-name], il log mostrato premedo ENTER sulla freccetta e' meglio di MasonLog

    sudo apt install python3.13-venv 
    sudo apt install python3-pip
    sudo apt install bundler

# Telescope
    sudo apt install ripgrep

