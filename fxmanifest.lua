fx_version 'bodacious'
game 'gta5'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

shared_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
}

client_script "client/main.lua"
