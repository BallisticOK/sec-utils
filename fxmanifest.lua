fx_version 'cerulean'
game 'gta5'

author '0x00sec'
description '0x00sec Utilities, Fixes & More!'
version '1.0.0'

client_script 'client/*.lua'
server_script 'server/*.lua'

server_scripts {
    "@oxmysql/lib/MySQL.lua",
}

client_scripts { 
	"postalCode-c.lua",
	"config.lua"
}
