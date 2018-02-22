require 'discordrb'
require 'open-uri'
require 'json'
require 'parallel'
# require 'steam-condenser'
load 'settings.rb'

bot = Discordrb::Commands::CommandBot.new(
  token: BotSettings::Token,
  client_id: BotSettings::Client_Id,
  prefix:'/',
)

def check_server_status(server)
  open("https://use.gameapis.net/csgo/query/info/#{server[:ip]}:#{server[:port]}", &:read)
  # TODO: steam-condenser たぶんはやい
end

def print_player_status(players)
  if players == []
    "none"
  else
    players
    .map{|player| "#{player['name']} (#{player['time']['minutes'].to_f.round(2)} min)"} # きれいにする
    .join(", ")
  end
end

def print_server_name(name, status)
  if (status)
    "__**#{name}**__ is __***UP!***__"
  else
    "~~#{name}~~ (Server Down)"
  end
end

def check_server_mode
  # TODO 書き方がゴミだからなんとかする
  enabled_plugins = `sudo ls /home/steam/Steam/csgo_ds/csgo/addons/sourcemod/plugins`
  if enabled_plugins.index("practicemode.smx") != nil
    "nade"
  elsif enabled_plugins.index("practicemode.smx") != nil
    "kouhaku"
  elsif enabled_plugins.index("practicemode.smx") != nil
    "retake"
  else
    "none"
  end
end

def create_server_status_msg(status, server)
  j = JSON.parse(status)
  server_name = "#{print_server_name(j['name'], j['status'])}\n"
  if j['status']
    return server_name + "```" \
    "#{server[:own_server] ? "Mode: " + check_server_mode + "\n" : ""}"\
    "Map: #{j['map']}\n" \
    "Players (#{j['players']['online']}/#{j['players']['max']}): #{print_player_status(j['players']['list'])}" \
    "```" \
    "join→\t\t #{server[:password] ? j['join']+server[:password] : j['join']}\n"
  else
    return nade_server_name
  end
end

Help_text = "`/saikyou status` : 全サーバーのステータスを表示\n"\
  "`/saikyou restart` : serverを立ち上げる/立ち上げ直す\n"\
  "`/saikyou update` : serverをupdate\n"\
  "`/saikyou mode {nade|kouhaku|retake}` : serverのモードを変えて立ち上げ直す\n"\
  "`/saikyou instance-restart` : serverのインスタンスをrestart（普通はやるな）\n"

bot.command :'saikyou' do |event, cmd, arg|
  case cmd
  when /restart|update|start|stop/
    `sudo -u steam /etc/init.d/csgo-server-launcher #{cmd}`
    event.respond("Done!")
  when "mode"
    case arg
    when "nade"
#      `sudo -u steam ./kouhaku_mode/disable_kouhaku_mode.sh`
      `sudo -u steam ./retake_mode/disable_retake_mode.sh`
      `sudo -u steam ./nade_mode/enable_nade_mode.sh`
      event.respond("Changed to nade mode. Restarting...")
      `sudo -u steam /etc/init.d/csgo-server-launcher restart`
      event.respond("Done!")
    when "kouhaku"
      event.respond("未実装")
    #   `sudo -u steam ./retake_mode/disable_retake_mode.sh`
    #   `sudo -u steam ./nade_mode/disable_nade_mode.sh`
    #   `sudo -u steam ./kouhaku_mode/enable_kouhaku_mode.sh`
    when "retake"
      `sudo -u steam ./nade_mode/disable_nade_mode.sh`
#      `sudo -u steam ./kouhaku_mode/disable_kouhaku_mode.sh`
      `sudo -u steam ./retake_mode/enable_retake_mode.sh`
      event.respond("Changed to nade mode. Restarting...")
      `sudo -u steam /etc/init.d/csgo-server-launcher restart`
      event.respond("Done!")
    else
      event.respond("#{event.user.mention}\n" + "`/saikyou mode {nade|kouhaku|retake}`")
    end
  when "instance-restart"
    event.respond("未実装")
  when "status"
    msgs = Parallel.map(BotSettings::Servers){|server|
      create_server_status_msg(check_server_status(server), server)
    }
    event.respond("#{event.user.mention}\n" + msgs.join("\n"))
  else
    event.respond("#{event.user.mention}\n" + Help_text)
  end
end

bot.mention do |event|
  event.respond("#{event.user.mention}\n" + Help_text)
end

bot.run
