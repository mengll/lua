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
