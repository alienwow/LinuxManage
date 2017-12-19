接下来开始测试：

打开Chrome浏览器，发起websocket请求：
var ws = new WebSocket("ws://10.99.20.85/sub/abc");
ws.onmessage = function(evt){console.log(evt.data);};

然后在服务器端推送消息：
curl --request POST --data "test message1" http://10.99.20.85:80/pub/abc
curl --request POST --data "test message2" http://10.99.20.85:80/pub/abc
curl --request POST --data "test message3" http://10.99.20.85:80/pub/abc

