

#import <UIKit/UIKit.h>

/**
 *  下拉菜单的基本cell,  自定义cell继承这个cell即可
 */
@interface YHSDropDownMenuBasedCell : UITableViewCell

{
    @public
    id _menuModel;
}

/** 菜单模型 */
@property (nonatomic, strong) id menuModel;

@end
