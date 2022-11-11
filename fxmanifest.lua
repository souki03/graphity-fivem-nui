fx_version 'bodacious'
game 'gta5'
client_script "nui.lua"
ui_page "html/index.html"
files {
    'html/index.html',
    'html/index.js',
    'html/index.css'
}
client_scripts {
	'config.lua',
	'lua/cl/warmenu.lua',
	'lua/cl/fonts.lua',
	'lua/cl/determinant.lua',
	'lua/cl/raycast.lua',
	'lua/cl/client.lua',
	'lua/cl/spray_rotation.lua',
	'lua/cl/control.lua',
	'lua/cl/remove.lua',
	'lua/cl/time.lua',
	'lua/cl/cancellable_progress.lua',
}
server_scripts {
	'config.lua',
	'@mysql-async/lib/MySQL.lua',
	'lua/sv/db.lua',
	'lua/sv/server.lua',
	'lua/sv/remove.lua',
}