#!/bin/sh
# gamemode_casual_serverをつくる
cp /home/steam/Steam/csgo_ds/csgo/cfg/gamemode_casual.cfg /home/steam/Steam/csgo_ds/csgo/cfg/gamemode_casual_server.cfg
sed -i "s/mp_warmuptime.*/mp_warmuptime 0/" /home/steam/Steam/csgo_ds/csgo/cfg/gamemode_casual_server.cfg
tee -a /home/steam/Steam/csgo_ds/csgo/cfg/gamemode_casual_server.cfg << END
sv_cheats 1
mp_warmup_end
mp_restartgame 1
mp_roundtime_defuse 60
mp_roundtime_hostage 60
impulse 101
bot_kick
bot_dont_shoot 1
bot_stop 1
sv_infinite_ammo 1
mp_autoteambalance 0
mp_freezetime 0

// startmoneyの設定
mp_startmoney 64000
mp_maxmoney 64000
mp_afterroundmoney 64000
ammo_grenade_limit_total 6

sv_showimpacts 3
sv_grenade_trajectory 1
sv_grenade_trajectory_thickness 0.5

mp_buytime 999999
mp_buy_anywhere 1
mp_respawn_on_death_t 1
mp_respawn_on_death_ct 1

// オートキック切る
mp_autokick 0

mp_limitteams 10

// ラウンド終わらないようにする
mp_ignore_round_win_conditions 1

// ブーストできるようにする
mp_solid_teammates 1
END

# server.cfgをコピー
cp /home/ubuntu/saikyou-server/saikyou-bot/nade_mode/server.cfg /home/steam/Steam/csgo_ds/csgo/cfg/server.cfg

# smxを移動
mv /home/steam/Steam/csgo_ds/csgo/addons/sourcemod/plugins/disabled/practicemode.smx /home/steam/Steam/csgo_ds/csgo/addons/sourcemod/plugins/practicemode.smx
