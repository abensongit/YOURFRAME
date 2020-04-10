
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CFCCollectionRefreshViewWaterFallLayoutDelegate <NSObject>
@optional;
#pragma mark 表格每一个分组的列数
- (NSInteger)numberOfColumnsInSectionForIndexPath:(NSIndexPath *)indexPath;
#pragma mark 表格每一行的高度
- (CGFloat)heightOfCellItemForCollectionViewAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark 表格的 SectionHeader 的高度
- (CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;
#pragma mark 表格的 SectionFooter 的高度
- (CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;
@end


@interface CFCCollectionRefreshViewWaterFallLayout : UICollectionViewLayout

// 边距
@property (nonatomic, assign) NSInteger margin;

// 行数
@property (nonatomic, assign) NSInteger columnsCount;

// 高度
@property (nonatomic, assign) CGFloat cellHeight;

// 四边的距离
@property (nonatomic,assign) UIEdgeInsets sectionInset;

// 分组头与尾高度
@property (nonatomic, assign) id<CFCCollectionRefreshViewWaterFallLayoutDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
