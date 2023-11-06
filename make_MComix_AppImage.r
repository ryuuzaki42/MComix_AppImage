
## Get appimagetool
    wget https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage
    chmod +x appimagetool-x86_64.AppImage

## Get Pyhton AppImage
    wget https://github.com/niess/python-appimage/releases/download/python3.11/python3.11.6-cp311-cp311-manylinux_2_28_x86_64.AppImage

    fileName=$(ls python3*.AppImage)
    chmod +x "$fileName"

    ./"$fileName" --appimage-extract
    cd squashfs-root/opt/python3*/bin/

## Install MComix
    # https://sourceforge.net/projects/mcomix/files/
    # https://sourceforge.net/p/mcomix/wiki/Installation/

    version="3.0.0"
    wget https://sourceforge.net/projects/mcomix/files/MComix-$version/mcomix-$version.tar.gz

    tar -xvf mcomix-$version.tar.gz
    rm mcomix-$version.tar.gz

    cd mcomix-$version/
    ../python3.* -m pip install .

    cd ../../../../

    # Upgrade pip
    #../python3.* -m pip install --upgrade pip

## Make AppImage
    rm -v python* .DirIcon AppRun

    #find . | grep ".png"
    #find . | grep ".svg"
    cp ./opt/python3*/lib/python3.11/site-packages/mcomix/images/mcomix.png .

    #find . | grep ".desktop"
    cp ./opt/python3*/bin/mcomix-3.0.0/share/applications/mcomix.desktop .
    #cat mcomix.desktop

    sed -i "s/Name=MComix/Name=MComix-$version/" mcomix.desktop
    mv mcomix.desktop MComix.desktop
    #cat MComix.desktop

    cd ../
    cp AppRun squashfs-root/
    cp README.md squashfs-root/
    #ls -lah squashfs-root/

    #rm -r squashfs-root/opt/python3*/bin/mcomix-$version/

    ARCH=x86_64 ./appimagetool-x86_64.AppImage squashfs-root/
    #ls -lah

    fileName=$(ls MComix*.AppImage)
    echo "fileName: $fileName"
    fileNameNew=$(echo "$fileName" | sed 's/.AppImage//')
    mv "$fileName" "${fileNameNew}-1_JB.AppImage"
    md5sum "${fileNameNew}-1_JB.AppImage" > "${fileNameNew}-1_JB.AppImage.md5"
