

#ifndef _CFC_SYS_URL_MACRO_H_
#define _CFC_SYS_URL_MACRO_H_


#pragma mark -
#pragma mark 系统接口
#define URL_API_APPENDING(URL)                               [CFCNetworkHTTPSessionUtil makeRequestWithBaseURLString:URL_API_BASE URLString:URL]


#pragma mark -
#if DEBUG
// 测试环境
#define URL_API_BASE                                         @"http://128.14.157.84/api"
#elif RELEASE
// 生产环境
#define URL_API_BASE                                         @"http://128.14.157.84/api"
#else
// 其它环境
#define URL_API_BASE                                         @"http://128.14.157.84/api"
#endif


#pragma mark -
// 首页 - 获取主页数据
#define URL_API_HOME_MAIN                                    URL_API_APPENDING(@"/init")


#endif /* _CFC_SYS_URL_MACRO_H_ */






