

#import "YHSDropDownMenuModel.h"


@implementation YHSDropDownMenuModel

/**
 *  快速实例化一个下拉菜单模型
 *
 *  @param menuItemTitle    菜单选项的标题
 *  @param menuItemIconName 菜单选项的图标名称
 *  @param menuBlock        点击的回调block
 *
 *  @return 实例化的菜单模型
 */
+ (instancetype)yhs_DropDownMenuModelWithMenuItemTitle:(NSString *)menuItemTitle
                                     menuItemIconName:(NSString *)menuItemIconName
                                            menuBlock:(YHSMenuBlock)menuBlock {
    YHSDropDownMenuModel *model = [YHSDropDownMenuModel new];
    model.menuItemTitle = menuItemTitle;
    model.menuItemIconName = menuItemIconName;
    model.menuBlock = menuBlock;
    model.cellClassName = @"YHSDropDownMenuCell";
    return model;
}

@end
