
#import "CFCTableRefreshViewController+EmptyDataSet.h"

@implementation CFCTableRefreshViewController (EmptyDataSet)

#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"没有查找到相关数据";
    
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:CFC_AUTOSIZING_FONT(16.0f)],
                                  NSForegroundColorAttributeName : [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.00]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSString *text = @"";
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:CFC_AUTOSIZING_FONT(16.0f)],
                                  NSForegroundColorAttributeName:[UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.00],
                                  NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    CGFloat width = self.view.width*0.8;
    return [[UIImage imageNamed:ICON_SCROLLVIEW_EMPTY_DATASET_RESULT] imageScaledFittingToSize:CGSizeMake(width, width*0.56)];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return - CFC_AUTOSIZING_HEIGTH(50.0f);
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

#pragma mark - DZNEmptyDataSetDelegate Methods

#pragma mark 是否显示空白页
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.isEmptyDataSetShouldDisplay;
}

#pragma mark 是否允许滚动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return self.isEmptyDataSetShouldAllowScroll;
}

#pragma mark 图片是否要动画效果
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
{
    return self.isEmptyDataSetShouldAllowImageViewAnimate;
}

@end


