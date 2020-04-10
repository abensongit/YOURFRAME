

#import "YHSDropDownMenuBasedModel.h"

/**
 *  下拉菜单模型
 */
@interface YHSDropDownMenuModel : YHSDropDownMenuBasedModel


/** 菜单选项标题 */
@property (nonatomic, copy) NSString *menuItemTitle;

/** 菜单选项图标名称 */
@property (nonatomic, copy) NSString *menuItemIconName;


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
                                            menuBlock:(YHSMenuBlock)menuBlock;

@end
