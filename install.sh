#!/bin/bash

function check_result() {
    if [ $? -ne 0 ]; then
        echo " "
        echo "do command failed for $1 !!!"
        echo " "
        exit 1
    fi
}

#Build ctp/lts/ib api
echo "是否要安装'CTP'接口? (Do you need 'CTP' interface?)"
read -p "Enter [y]n: " var1
var1=${var1:-y}
if [ "$var1" = "y" ]; then
	pushd vnpy/api/ctp
	bash build.sh
	popd
fi


#Install Python Modules
pip install -r requirements.txt

#Install Ta-Lib
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
conda install -c quantopian ta-lib=0.4.9

#Install vn.py
python setup.py install

