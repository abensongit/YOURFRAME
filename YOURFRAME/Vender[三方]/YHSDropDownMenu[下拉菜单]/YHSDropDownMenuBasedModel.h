

#import <Foundation/Foundation.h>

// 定义一个菜单的block
typedef void(^YHSMenuBlock)(void);

/**
 *  下拉菜单的基本模型，所有自定义模型必须继承这个模型
 *
 *  注意:若自定义一个继承于这个类的菜单模型，必须要自定义一个继承于YHSDropDownMenuBasedCell的菜单cell
 */
@interface YHSDropDownMenuBasedModel : NSObject

/** 点击回调的block */
@property (nonatomic, copy) YHSMenuBlock menuBlock;

/** 展示Cell名称 */
@property (nonatomic, copy) NSString *cellClassName;

@end
