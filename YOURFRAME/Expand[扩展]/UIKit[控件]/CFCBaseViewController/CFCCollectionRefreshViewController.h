

#import "CFCBaseCommonViewController.h"
#import "CFCCollectionRefreshViewWaterFallLayout.h"
@protocol CFCCollectionRefreshViewWaterFallLayoutDelegate;

NS_ASSUME_NONNULL_BEGIN

#pragma mark 布局类型
typedef NS_ENUM(NSInteger, CFCCollectionViewLayoutType) {
  CFCCollectionViewLayoutTypeDefault = 100,   // 默认布局
  CFCCollectionViewLayoutTypeFlowLayout,      // 流式布局
  CFCCollectionViewLayoutTypeWaterFallLayout, // 瀑布布局
};


@interface CFCCollectionSectionNULLHeaderView : UICollectionReusableView

@end


@interface CFCCollectionSectionNULLFooterView : UICollectionReusableView

@end


@interface CFCCollectionRefreshViewController : CFCBaseCommonViewController <UICollectionViewDelegateFlowLayout, CFCCollectionRefreshViewWaterFallLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionViewRefresh; // UICollectionView表格

@property (nonatomic, strong) NSMutableArray *collectionViewDataRefresh; // UICollectionView数据源

@property (nonatomic, strong) MJRefreshHeader *collectionViewRefreshHeader; // 下拉刷新控件

@property (nonatomic, strong) MJRefreshFooter *collectionViewRefreshFooter; // 上拉刷新控件

@property (nonatomic, strong) NSString *showLoadingMessage; // 加载提示文字

@property (nonatomic, assign) BOOL isShowLoadingHUD; // 是否显示加载菊花（默认YES）

@property (nonatomic, assign) BOOL hasCollectionViewRefresh; // 是否创建UICollectionView表格（默认创建）

@property (nonatomic, assign) BOOL hasMultiRequestURL; // 是否多接口获取数据（默认NO）

@property (nonatomic, assign) BOOL hasRefreshHeader; // 是否可下拉刷新（默认YES）

@property (nonatomic, assign) BOOL hasRefreshFooter; // 是否可上拉刷新（默认YES）

@property (nonatomic, assign) BOOL hasRefreshOnce; // 是否只可下拉刷新1次（默认NO）(数据固定的页面使用，如：我的、设置)

@property (nonatomic, assign) BOOL hasCacheData; // 是否需要加载缓存（默认NO）

@property (nonatomic, assign) BOOL hasPage; // 是否需要分页（默认NO）

@property (nonatomic, assign) NSUInteger page; // 页数

@property (nonatomic, assign) NSUInteger limit; // 数量限制

@property (nonatomic, assign) NSUInteger offset; // 数据偏移量

@property (nonatomic, assign) CFCRequestMethod requestMethod; // 请求方式

@property (nonatomic, assign) BOOL isRequestNetwork; // 是否需要请求网络数据（默认YES）

@property (nonatomic, assign) BOOL isEmptyDataSetShouldDisplay; // 是否显示EmptyDataSet空白页（默认NO）

@property (nonatomic, assign) BOOL isEmptyDataSetShouldAllowScroll; // 是否允许滚动（默认YES）

@property (nonatomic, assign) BOOL isEmptyDataSetShouldAllowImageViewAnimate; // 图片是否要动画效果（默认YES）

@property (nonatomic, assign) BOOL isAutoLayoutSafeAreaTop; // 是否自动适配安全区域（iOS11安全区域）

@property (nonatomic, assign) BOOL isAutoLayoutSafeAreaBottom; // 是否自动适配安全区域（iOS11安全区域）


#pragma mark -
#pragma mark 请求数据 - 下拉刷新数据
- (void)loadData;

#pragma mark 请求数据 - 上拉加载数据
- (void)loadMoreData;

#pragma mark 请求数据 - 加载完数据前，其它操作，每次刷新加载数据前都会执行
- (void)viewDidLoadBeforeLoadNetworkDataOrCacheData;

#pragma mark 请求数据 - 加载完数据后，其它操作，每次刷新加载数据后都会执行
- (void)viewDidLoadAfterLoadNetworkDataOrCacheData;

#pragma mark 请求数据 - 单个接口 - 请求地址（子类继承实现）
- (NSString *)getRequestURLString;

#pragma mark 请求数据 - 单个接口 - 请求参数（子类继承实现）
- (NSMutableDictionary *)getRequestParamerter;

#pragma mark 请求数据 - 单个接口 - 请求网络设置（子类继承实现）
- (void)loadNetworkRequestSettingSingle;

#pragma mark 请求数据 - 单个接口 - 请求网络数据（请求逻辑处理）
- (void)loadNetworkDataSingleThen:(void (^)(BOOL success, BOOL isCache, NSUInteger count))then;

#pragma mark 请求数据 - 单个接口 - 请求网络数据或加载缓存（子类继承实现处理过程）
- (NSMutableArray *)loadNetworkDataOrCacheDataSingle:(id)responseDataOrCacheData isCacheData:(BOOL)isCacheData;

#pragma mark 请求数据 - 多个接口 - 请求子类（子类继承实现）
- (NSArray<CFCBaseRequest *> *)getRequestArrayMultiple;

#pragma mark 请求数据 - 多个接口 - 请求批量（子类继承实现）
- (CFCBaseBatchRequest *)getRequestBatchMultiple;

#pragma mark 请求数据 - 多个接口 - 请求网络设置（子类继承实现）
- (void)loadNetworkRequestSettingMultiple;

#pragma mark 请求数据 - 多个接口 - 请求网络数据（请求逻辑处理）
- (void)loadNetworkDataMultipleThen:(void (^)(BOOL success, BOOL isCache, NSUInteger count))then;

#pragma mark 请求数据 - 多个接口 - 请求网络数据或加载缓存（子类继承实现处理过程）
- (NSMutableArray *)loadNetworkDataOrCacheDataMultiple:(YTKBatchRequest * _Nonnull)batchRequest isCacheData:(BOOL)isCacheData;


#pragma mark -
#pragma mark 创建界面表格
- (void)createUIRefreshCollection:(BOOL)force;

#pragma mark 设置 UICollectionView（子类继承实现）
- (void)collectionViewRefreshSetting:(UICollectionView *)collectionView;

#pragma mark 注册 UICollectionView（子类继承实现）
- (void)collectionViewRefreshRegisterClass:(UICollectionView *)collectionView;

#pragma mark 设置 CFCCollectionViewLayoutType 布局
- (CFCCollectionViewLayoutType)collectionViewLayoutType;

#pragma mark 设置 CFCCollectionViewLayoutType 布局
- (UICollectionViewLayout *)collectionViewLayout;


#pragma mark -
#pragma mark UICollectionViewDataSource
#pragma mark 设置组数（默认1组）（可选实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
#pragma mark 每一个分组中 Cell 的个数（必须实现）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
#pragma mark 每一个分组 Cell 实例，使用dequeueReusableCellWithReuseIdentifier:forIndexPath:方法复用（必须实现）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark 返回组头/组尾视图，使用dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:方法复用（可选实现）
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
#pragma mark 设置某个 Cell 是否可以移动（可选实现）
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark 移动 Cell 的时候，会调用这个方法（可选实现）
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath;

#pragma mark -
#pragma mark UICollectionViewDelegate
#pragma mark 选中某个 Cell 时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark 取消选中某个 Cell 时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;


#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark 动态设置每个 Item（Cell）的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark 动态设置 Cell 的上下左右边界缩进
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
#pragma mark 动态设置 Cell 行间的间距最小距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
#pragma mark 动态设置 Cell 列间的间距最小距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
#pragma mark 动态设置组头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
#pragma mark 动态设置组尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;


#pragma mark - CFCCollectionRefreshViewWaterFallLayoutDelegate
#pragma mark 自定义表格每一个分组的列数
- (NSInteger)numberOfColumnsInSectionForIndexPath:(NSIndexPath *)indexPath;
#pragma mark 自定义表格每一行的高度
- (CGFloat)heightOfCellItemForCollectionViewAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark 自定义表格的 SectionHeader 的高度
- (CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;
#pragma mark 自定义表格的 SectionFooter 的高度
- (CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
