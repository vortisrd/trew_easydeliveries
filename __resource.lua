resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'TREW EasyDeliveries'

version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',
	'server/server.lua'
}