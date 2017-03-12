


import httplib

def http_get( host, port, url ):

	connection = httplib.HTTPConnection( host, port )
	connection.request("GET", url )
	response = connection.getresponse()
	print response.status, response.reason
	answer = response.read()
	connection.close()
	
	return [response.status, answer]	

# import vlc_remco_1
# vlc_remco_1.http_get( '127.0.0.1', 8080, '/requests/status.xml' )


