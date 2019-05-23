# NetHttpLog

一个基于AFNetWorking网络日志框架

进入某个VC之后，可以摇一摇查看网络请求日志

安装方式

pod 'NetHttpLog'


使用方式

第一步引入 #import <YYNetHttpLogConfig.h>

#if DEBUG
#define HttpNetLogEnabled TRUE
#else
#define HttpNetLogEnabled FALSE
#endif


[YYNetHttpLogConfig share].enabled = HttpNetLogEnabled


摇一摇就可以打开日志页面
