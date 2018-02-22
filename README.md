# 使い方
## やりかた（インストール）
- `Ubuntu Server 16.04 LTS (HVM), SSD Volume Type` を立てる
  - EBSは30GB
  - ポートはTCP22とTCP27015とUDP27000-27030, UDP4380をあける
    - たぶん

- 立てたインスタンスで `sudo apt-get install -y language-pack-ja`
  - なんか日本語がぶっ壊れてるので直す
- `git clone https://github.com/myagita/saikyou-server.git`
- `cd saikyou-server`
- `configure.sh` の設定項目を全部書く。これをやらないと死にます。
- 立てるサーバーのadminになる人を `admins_simple.tail.ini` に入れる。
- `./configure.sh`
- `./install.sh`
  - 開始10秒ぐらいでピンクい画面になるがEnterを押す
  - たぶん20分ぐらいかかる、CSGOがでかいので。
## ゲーム内の操作
- コンソールに`sm_rcon sv_showimpacts 1` とかできる（サーバーコマンドを実行できる）
- チャットに`!admin`でだいたいのことはできる
## サーバーの操作
- `/etc/init.d/csgo-server-launcher {start|stop|status|restart|console|update|create}`
  - screenで起動するからいいかんじになる

# やってること
## configure.sh
- AWSのまっさらな`Ubuntu Server 16.04 LTS (HVM), SSD Volume Type`インスタンス上にCSGOのサーバーをインストール
- sourcemodとmetamodも適切に入れる。
- csgo-practice-modeのインストール https://github.com/splewis/csgo-practice-mode
-
