//
//  Singleton.h
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//


/*
 \表示换行
 专门用来保存单例代码
 最后一行不要加 \
 */


//宏里面遇到反斜线，表示他下面一行的代码也是本行的代码
//宏里面遇到两个＃＃，表示连接，把前面的代码和后面的代码连接上
//宏里面遇到一个＃，表示＃后面的内容是用双引号引起的
//宏里面遇到一个＃@，表示＃@后面的内容是用单引号引起的


//在.h文件里倒入singleton_interface(className)方法
//在.m文件里倒入singleton_implementation(className)方法
//className代表倒入的类名

// @interface
#define singleton_interface(className) \
+ (className *)shared##className;


// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

/*
 说明:
 
 //在#define中，标准只定义了#和##两种操作。#用来把参数转换成字符串，##则用来连接两个前后两个参数，把它们变成一个字符串。
 
 #define Conn(x,y)    x##y   //连接x,y
 #define ToChar(x)    #@x    //加单引号
 #define ToString(x)  #x     //加双引号
 
 #define Conn(x,y) x##y
 #define ToChar(x) #@x
 #define ToString(x) #x
 
 x##y表示什么？表示x连接y，举例说：
 int n = Conn(123,456);   结果就是n=123456;
 char* str = Conn("asdf", "adf")结果就是 str = "asdfadf";
 
 
 再来看#@x，其实就是给x加上单引号，结果返回是一个const char。举例说：
 char a = ToChar(1);结果就是a='1';
 
 最后看看#x,他是给x加双引号
 char* str = ToString(123132);就成了str="123132";
 
 */



