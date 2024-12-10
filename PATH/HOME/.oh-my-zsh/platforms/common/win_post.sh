
export "EDITOR=zvim"
export "PATH=$CMDROOT/PATH/bin:$PATH"
export "PATH=$CMDROOT/PATH/bind-dig:$PATH"
export "PATH=$CMDROOT/PATH/miniconda3:$PATH"
export "PATH=$CMDROOT/PATH/SysinternalsSuite:$PATH"
#export "PATH=$CMDROOT/PATH/nirsoft_package_enc_1.23.49/NirSoft:$PATH"
export "PATH=$CMDROOT/PATH/nirsoft_package_enc_1.30.2/NirSoft:$PATH"
export "PATH=$CMDROOT/PATH/Notepad2_v4.2.25:$PATH"
export "PATH=$CMDROOT/PATH/scripts:$PATH"
export "PATH=$CMDROOT/PATH/linux-utils:$PATH"

export "GOROOT=$CMDROOT/PATH/go"
export "PATH=$GOROOT/bin:$PATH"

export "mingw64=$CMDROOT/PATH/mingw64"
export "PATH=$mingw64/bin:$PATH"

[ -f "$HOME/WinHome/.zshrc" ] || touch "$HOME/WinHome/.zshrc"
source "$HOME/WinHome/.zshrc"

[ -d '/v' ] && cd '/v'

