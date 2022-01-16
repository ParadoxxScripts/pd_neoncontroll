fx_version 'adamant'

game 'gta5'

description 'ParadoxDev - Neoncontroll'

version '1.0'

client_scripts {
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

files {
	'html/ui.html',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
	'html/BebasNeue.ttf',
	'html/images/*.png'
}

ui_page 'html/ui.html'
