### openresty 常用命令
``` 
-- 生产的消息直接进入kafka 安全的模式返回
local cjson = require "cjson.safe"
local client = require "resty.kafka.client"
local producer = require "resty.kafka.producer"
local resty_uuid = require "resty.uuid"

local broker_list = {
    {host = "172", port = 9092 },
    { host = "24", port = 9092 },
    { host = "172", port = 9092 },
}

--读取上报的信息体的内容转化
ngx.req.read_body()   
local body = ngx.req.get_body_data()
local key = "ana"
local back_data = {}
back_data["code"] = 1
back_data["msg"] = ""

-- 异步生产信息
local bp = producer:new(broker_list, { producer_type = "async" })
local ok, err = bp:send("fk_01", key, body)
if not ok then
    back_data["code"] = 0
    back_data["msg"] = "kafka error"
    ngx.say(cjson.encode(back_data))
    return
end

local str_find = string.find
-- 判断当前时候是初始化
local back = {}
local req_uri = ngx.var.request_uri
if str_find(req_uri,"init") then
    back["online_interval"] = 60
    back["event_queue_cap"] = 10
    back["interval_upload"] = 300 -- 间隔时间
    back["buried_point_cap"] = 10  -- 埋点
    back["session_id"] = resty_uuid:generate()
end
back_data["data"] = back
ngx.say(cjson.encode(back_data))

-- ngx.req.get_post_args()   获取post传递的body的内容信息
-- ngx.req.get_method()  获取调用的方法的操作  
-- ngx.say()  打印内容主题
-- ngx.redirect 冲昂达影响的过程
-- ngx.unescape_uri 解析当前的业务数据
-- 加载模块等耗时操作放在初始化的过程中
-- 获取传递的变量的方法，ngx.var.arg_变量名称
-- 获取get 请求的路径 ngx.var.request_uri   /?name=12&hk=1223 获取的都是字符串
-- 正则表达式的捕获组 ngx.var[1]  获取内容 内容  
-- 获取服务的请求的头 ngx.req.get_headers() 可使用 pairs 遍历
-- 获取相应的请求参数  ngx.req.get_uri_args()   
-- 网络请求的转码  ngx.escape_uri()   ngx.unescape_uri()  转码
-- 获取当前的MD5  ngx.md5()
-- NGINX 获取的时间是缓存的时间  ngx.time() 秒,ngx.now() 毫秒级别 ngx.update_time() 更新缓存的时间
-- NGINX中的正则  local m,err = ngx.re.match(msk,'\\w+') 有转移符的，要实现正则的转义 
-- 错误日志的输出级别 ngx.ERR ngx.INFO 间断性
-- 还是用 pcall 的方式调用  ok,t = pcall(func,args) 返回当前的结果 处理错误的信息
--[[
    连接Redis的服务器的操作  redis  使用的是resty.redis的模块开发 其中存在变化的数据转化的过程，和相关的内容数据连接和数据断开的操作
    redis redis:setkeepalive() 
]]--

-- 同一个worker 中连接池 是不是 red:get_reused_times  被用的次数 该链接被使用的次数，则不是从连接池中获取的，当前的值肯定是大于零的 两个业务数据错误
-- openresty 执行时按照相应的执行阶段，执行的 set 执行的 rewrite 阶段执行的   echo 输出的
-- 1 post-read 读取内容阶段，解析完，请求头之后，立即开始执行 模块运行在 ngx_realip 就在 post-read 注册了处理程序
-- 2 server-rewrite 阶段请求地址重写阶段 set 配置指令直接书写在server配置块中
-- 3 find-config 配置查找阶段 不支持NGINX模块注册处理
-- 4 rewrite location 请求地址重写阶段 ngx_rewite 阶段就在这执行
-- 5 post-rewrite 请求地址提交阶段 当前NGINX 完成rewrite阶段，要求的内部跳转链接 
-- 6 ngx.location.capture_multi({) 多级子查询 for ${aj[@]} 获取元素内的全部元素
```
