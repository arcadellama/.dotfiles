### Fonts

#### Update git submodule

    git submodule update --init --recursive


#### Install font

    sudo mkdir -p /usr/local/share/fonts/<font-family-name>

    sudo cp ~/path/to/font/dir/*.{ttf,otf} \
        /usr/local/share/fonts/<font-family-name>/

    sudo chown -R root: /usr/local/share/fonts/<font-family-name>

    sudo chmod 644 /usr/local/share/fonts/<font-family-name>*

    sudo fc-cache -v
