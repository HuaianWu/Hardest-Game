
//加＃的叫预编译



// 判断是否为iPhone5
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)


#import "UIView+Image.h"



/*
说明:
#define debug(…) printf(__VA_ARGS__)
缺省号代表一个可以变化的参数表。使用保留名 __VA_ARGS__ 把参数传递给宏。当宏的调用展开时，实际的参数就传递给 printf()了。例如：
Debug(“Y = %d\n”, y);
而处理器会把宏的调用替换成：
printf(“Y = %d\n”, y);
因为debug()是一个可变参数宏，你能在每一次调用中传递不同数目的参数：
debug(“test”); //一个参数
*/

// 自定义Log
#ifdef DEBUG // 调试
#define MyLog(...) NSLog(__VA_ARGS__)
#else // 发布打包
#define MyLog(...)
#endif




