fx_version 'cerulean'
game 'gta5'
lua54 'yes'

Autore 'Karos#7804'
Descrizione 'krs_moneywash'
version '1.0.0'

client_scripts {
    'script/client/client.lua'
}

server_scripts {
    'script/server/server.lua',
}

shared_scripts {
    '@es_extended/imports.lua',
    "@ox_lib/init.lua",
    'config.lua'
}

files {
    'script/html/*.*'
}

ui_page 'script/html/index.html'

dependencies {
    'ox_target',
    'gridsystem',
    'ox_lib',
}