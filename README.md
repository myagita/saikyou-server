# 使い方
## やりかた（インストール）
- `Ubuntu Server 18.04 LTS (HVM), SSD Volume Type` を立てる
  - t2.micro
  - EBSは30GB
  - ポートはTCP22とTCP27015とUDP27000-27030, UDP4380をあける
    - たぶん

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
- `sudo -u steam /etc/init.d/csgo-server-launcher {start|stop|status|restart|console|update|create}`
  - screenで起動するからいいかんじになる
  - 起動したはずなのに繋がらない時、`console` してみると実はなんかアップデートしてる時がある
