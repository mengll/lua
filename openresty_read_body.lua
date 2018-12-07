Nginx中可以使用在lua块中使用ngx.req.get_body_data()获取http请求的消息体。

代码如下：

server {
     listen 7070;
     charset utf-8;
     server_name localhost;
     location ~/yxl/(.*)/(.*) {
         content_by_lua_block {
              local data = ngx.req.get_body_data()
              ngx.say(data)
         }
     }
}

但默认情况下可能会得到一个nil的结果。这是因为之前nginx的定位是消息转发，而不是处理消息体。若需要获取消息体，需要在打开获取消息体的开关。增加一行代码：lua_need_request_body on;

代码如下：

server {
     listen 7070;
     charset utf-8;
     server_name localhost;
     lua_need_request_body on;
     location ~/yxl/(.*)/(.*) {
         content_by_lua_block {
              local data = ngx.req.get_body_data()
               ngx.say(data)
         }
     }
}

如此即可顺利获取消息体的内容。

但上述方法强制本模块读取消息体，因此不推荐使用，获取消息体推荐使用以下方法，在获取消息体代码附近，增加一句ngx.req.read_body()，代码如下：

server {
     listen 7070;
     charset utf-8;
     server_name localhost;
     location ~/yxl/(.*)/(.*) {
         content_by_lua_block {

             ngx.req.read_body()
              local data = ngx.req.get_body_data()
               ngx.say(data)
         }
     }
}
--------------------- 
作者：暗日狂沙 
来源：CSDN 
原文：https://blog.csdn.net/yxl0011/article/details/72819874 
版权声明：本文为博主原创文章，转载请附上博文链接！
