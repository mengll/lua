# lua
lua学习笔记
### openresty   通过mac安装的目录位置 /usr/local/opt/openresty 下面
### openesty    的配置文件放在  /usr/local/etc/openresty 下面
```
 loadfile("file") 只是单纯的加载  文件但是不会运行
 dofile("file")  加载文件并运行，可重复的加载
 require("file") 只加载一次，并运行
 
ll = os.time()
print(ll) 返回当前的时间戳
print(os.date("%Y-%m-%d",t))  -- lua 中的时间格式化 格式化时间输出
```
### openresty 生成证书的请求
curl  -v -s -k 'https://api.weixin.qq.com/cgi-bin/token?xxxx' 

### openresty kafka 自动分区

local ok, err = bp:send("ocpc_log", key, message)

当key 有值的时候数据会分配到指定的分区
当key 为 nil 的时候会自动的分区


### luajit在Mac系统下编译的时候需要制定目标系统的版本
export MACOSX_DEPLOYMENT_TARGET=12.1

源码安装 

```
-- 编译的参数地址
make PREFIX=/path/to/luajit

-- 安装的参数地址
make install PREFIX=/path/to/luajit

```
