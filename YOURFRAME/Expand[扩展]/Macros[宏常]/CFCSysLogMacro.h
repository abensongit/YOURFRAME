

#ifndef _CFC_SYSLOG_MACRO_H_
#define _CFC_SYSLOG_MACRO_H_

/* 控件台打印 */
#ifdef DEBUG
#define CFCLog(format, ...) printf("[%s] [DEBUG] %s [第%d行] => %s \n", [[CFCLogUtil getCurrentTimeStamp] UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define CFCLog(__FORMAT__, ...)
#endif


#define STR_APP_TEXT_DATA_CACHE             @"[缓存数据]"
#define STR_APP_TEXT_DATA_NETWORK           @"[网络数据]"
#define CFC_DATA_TYPE(isCacheData)          (isCacheData?STR_APP_TEXT_DATA_CACHE:STR_APP_TEXT_DATA_NETWORK)

#endif /* _CFC_SYSLOG_MACRO_H_ */

