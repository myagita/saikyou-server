# !!! 設定 !!!
gslt="" # gsltを書く
nade_server_name="Neru Nagahama kawaii" # nade serverの名前
nade_server_password="" # nade serverのパスワード。空欄ならパスワードなし（たぶん）
retake_server_name="Mizuki Yamashita mo kawaii" # retake serverの名前
retake_server_password="" # retake serverのパスワード。空欄ならパスワードなし

# 実際にconfigure
sed -i "s/REALGSLTCOMESHERE/$gslt/" install.sh
sed -i "s/REALSERVERNAMECOMESHERE/$nade_server_name/" saikyou-bot/nade_mode/server.cfg
sed -i "s/REALSERVERPASSCOMESHERE/$nade_server_password/" saikyou-bot/nade_mode/server.cfg
sed -i "s/REALSERVERNAMECOMESHERE/$retake_server_name/" saikyou-bot/retake_mode/server.cfg
sed -i "s/REALSERVERPASSCOMESHERE/$retake_server_password/" saikyou-bot/retake_mode/server.cfg
