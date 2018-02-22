#!/bin/sh

# とりあえずいろいろアップデートしたりSteamインストールに必要ななんかをいれる
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get -y install language-pack-ja lib32gcc1 gdb lib32stdc++6 unzip ruby ruby-bundler ruby-dev build-essential g++

# Steamをインストール
sudo useradd -m steam
sudo su steam -c "mkdir ~/Steam"
sudo su steam -c "cd /home/steam/Steam && curl -sqL 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxvf -"

# インストールされたSteamを使ってcsgoをインストール
sudo su steam -c "/home/steam/Steam/steamcmd.sh +login anonymous +force_install_dir /home/steam/Steam/csgo_ds +app_update 740 +quit"

# csgo serverをいい感じにやってくれるやつをインストール
wget https://raw.githubusercontent.com/crazy-max/csgo-server-launcher/master/install.sh --no-check-certificate -O install-csgo-server-launcher.sh
chmod +x install-csgo-server-launcher.sh
sudo ./install-csgo-server-launcher.sh
# 設定変更 /etc/csgo-server-launcher/csgo-server-launcher.conf
sudo sed -i "s/GSLT=.*/GSLT=\"REALGSLTCOMESHERE\"/"  /etc/csgo-server-launcher/csgo-server-launcher.conf
sudo sed -i 's/DIR_ROOT=.*/DIR_ROOT=\"\/home\/steam\/Steam\/csgo_ds\"/'  /etc/csgo-server-launcher/csgo-server-launcher.conf
# 'steam'というアカウントでscreenできるようにする
sudo -u steam tee -a /home/steam/.bashrc << END
function screen() {
  /usr/bin/script -q -c "/usr/bin/screen ${*}" /dev/null
}
END
# sourcemodをインストール
sudo su steam -c "wget https://sm.alliedmods.net/smdrop/1.8/sourcemod-1.8.0-git6041-linux.tar.gz -P /home/steam/Steam/csgo_ds/csgo/"
sudo su steam -c "tar xvzf /home/steam/Steam/csgo_ds/csgo/sourcemod-1.8.0-git6041-linux.tar.gz -C /home/steam/Steam/csgo_ds/csgo/"

# metamod.vdfを作成
sudo -u steam tee -a /home/steam/Steam/csgo_ds/csgo/addons/metamod.vdf << END
"Plugin"
{
  "file"  "../csgo/addons/metamod/bin/server"
}
END

# adminを追加
cat admins_simple.tail.ini | sudo -u steam tee -a /home/steam/Steam/csgo_ds/csgo/addons/sourcemod/configs/admins_simple.ini

# csgo-practice-modeをインストール
sudo -u steam wget https://github.com/splewis/csgo-practice-mode/releases/download/1.2.2/practicemode_1.2.2.zip -P /home/steam/Steam/csgo_ds/csgo
sudo -u steam unzip -o /home/steam/Steam/csgo_ds/csgo/practicemode_1.2.2.zip -d /home/steam/Steam/csgo_ds/csgo/
sudo -u steam mv /home/steam/Steam/csgo_ds/csgo/addons/sourcemod/plugins/practicemode.smx /home/steam/Steam/csgo_ds/csgo/addons/sourcemod/plugins/disabled/practicemode.smx

# csgo-retakesをインストール
sudo -u steam wget https://github.com/splewis/csgo-retakes/releases/download/v0.3.4/retakes_0.3.4.zip -P /home/steam/Steam/csgo_ds/csgo
sudo -u steam unzip -o /home/steam/Steam/csgo_ds/csgo/retakes_0.3.4.zip -d /home/steam/Steam/csgo_ds/csgo/
sudo -u steam mv /home/steam/Steam/csgo_ds/csgo/addons/sourcemod/plugins/retakes.smx /home/steam/Steam/csgo_ds/csgo/addons/sourcemod/plugins/disabled/retakes.smx
