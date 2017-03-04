
'''

import PythonTests


'''

import httplib


class PythonTests(object):
	
	# PythonTests.PythonTests.hello_world()
	@staticmethod
	def hello_world():
		print 'hello guido'

	# PythonTests.PythonTests.hello('quido')
	@staticmethod
	def hello(to):
		print 'hello', to
	
	@staticmethod
	def div( a, b ):
		return a/b
	
	@staticmethod
	def div0():
		return div(0,0)
	
	@staticmethod
	def ping():
		return
	
	@staticmethod
	def echo(parm):
		return parm


	# PythonTests.PythonTests.http_get( '127.0.0.1', 8080, '/requests/status.xml' );
	@staticmethod
	def http_get( host, port, url ):
	
		print 'python: host =', host 
		print 'python: port =', port 
		print 'python: url =', url
	
		connection = httplib.HTTPConnection( host, port )
		connection.request("GET", url )
		response = connection.getresponse()
		print response.status, response.reason
		answer = response.read()
		connection.close()
	
		return [response.status, answer]	
	
