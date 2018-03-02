

Scratch
=======



curl -d '["request",{},"jsonbroker.TestService",1,0,"ping",{}]' http://127.0.0.1:8081/_dynamic_/open/services



-------------------------------------------------------------------------------

Environment
===========


```
export PORT=4130
export HOST=127.0.0.1
```


```
export PORT=8081
export HOST=127.0.0.1
```

-------------------------------------------------------------------------------


```
curl -d '["request",{},"remote_gateway.AppleScriptService.system-test",1,0,"ping",[]]' http://$HOST:$PORT/_dynamic_/open/services
```


```
curl -d '["request",{},"remote_gateway.AppleScriptService.system-test",1,0,"echo",["Hello Applescript!"]]' http://$HOST:$PORT/_dynamic_/open/services
```
