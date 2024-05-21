fx_version 'cerulean'
game 'gta5'

name "qb-itemcreator"
description "Create Items With Ease."
author "Drk"
version "1.0"

shared_scripts {
	'config.lua',
	'@ox_lib/init.lua',
}

client_scripts {
	'client.lua',
}

server_scripts {
	'server.lua',
	'@oxmysql/lib/MySQL.lua',
}

dependencies {
	'ox_lib',
}

lua54 'yes'