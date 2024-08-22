fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'krs_moneywash'
author 'Karos#7804'

shared_scripts { 

	'@ox_lib/init.lua',
	'shared/*.lua'
}

client_scripts {	
	'client/*.lua'
}

server_scripts {
	
	'server/*.lua'
}

files {
    'locales/*.json'
}

dependencies {
	
	'ox_lib',
	'ox_inventory'
}
