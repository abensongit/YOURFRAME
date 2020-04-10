

#import "CFCCollectionRefreshViewController.h"
#import "CFCCollectionRefreshViewWaterFallLayout.h"
#import "CFCBaseBatchRequest.h"
#import "CFCBaseRequest.h"


// Section Header Identifier
NSString * const CELL_IDENTIFIER_COLLECTION_SECTION_NULL_HEADER = @"CFCCollectionSectionNULLHeaderIdentifier";

// Section Footer Identifier
NSString * const CELL_IDENTIFIER_COLLECTION_SECTION_NULL_FOOTER = @"CFCCollectionSectionNULLFooterIdentifier";

@implementation CFCCollectionSectionNULLHeaderView

@end

@implementation CFCCollectionSectionNULLFooterView

@end


@interface CFCCollectionRefreshViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CFCBaseRequest *requestOfSingle;

@property (nonatomic, strong) CFCBaseBatchRequest *requestOfMultiple;

@end


@implementation CFCCollectionRefreshViewController

#pragma mark -
#pragma mark 视图生命周期（初始化）
- (instancetype)init
{
  self = [super init];
  if (self) {
    _page = 0;
    _limit = 10;
    _offset = 0;
    
    _isShowLoadingHUD = YES; // 是否显示加载菊花
    _showLoadingMessage = CFCLoadingProgessHUDText; // 加载提示文字
    
    _hasCollectionViewRefresh = YES; // 是否创建表格（默认YES）
    _hasMultiRequestURL = NO; // 是否多接口获取数据（默认NO）
    _hasRefreshHeader = YES; // 是否可下拉刷新（默认YES）
    _hasRefreshFooter = YES; // 是否可上拉加载（默认YES）
    _hasRefreshOnce = NO; // 是否只可下拉刷新1次（默认NO）(数据固定的页面使用，如：我的、设置)
    _hasCacheData = NO; // 是否需要加载缓存（默认NO）
    _hasPage = NO; // 是否需要分页（默认NO）
    
    _requestMethod = CFCRequestMethodGET; // 默认GET请求
    _isRequestNetwork = YES; // 是否需要请求网络数据（默认YES）
    
    _isEmptyDataSetShouldDisplay = NO; // 是否显示EmptyDataSet空白页（默认NO）
    _isEmptyDataSetShouldAllowScroll = YES; // 是否允许滚动（默认YES）
    _isEmptyDataSetShouldAllowImageViewAnimate = YES; // 图片是否要动画效果（默认YES）
    
    _isAutoLayoutSafeAreaTop = YES; // 是否自动适配安全区域（iOS11安全区域）
    _isAutoLayoutSafeAreaBottom = NO; // 是否自动适配安全区域（iOS11安全区域）
  }
  return self;
}

#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
  [super viewDidLoad];
  
}

#pragma mark 监听网络变化后执行 - 有网络
- (void)viewDidLoadWithNetworkingStatus
{
  // 配置UI界面
  [self createUIRefreshCollection:YES];
  
  // 请求网络数据
  if (self.isRequestNetwork) {
    if (self.isShowLoadingHUD) {
      [self loadData];
    } else {
      [self.collectionViewRefresh.mj_header beginRefreshing];
    }
  }
}

#pragma mark 监听网络变化后执行 - 无网络
- (void)viewDidLoadWithNoNetworkingStatus
{
  // 配置UI界面
  [self createUIRefreshCollection:YES];
  
  // 重新设置可刷新数据
  [self.collectionViewRefresh setMj_header:self.collectionViewRefreshHeader];
  [self.collectionViewRefresh setMj_footer:self.collectionViewRefreshFooter];
  
  // 请求网络数据
  if (self.isRequestNetwork) {
    if (self.isShowLoadingHUD) {
      [self loadData];
    } else {
      [self.collectionViewRefresh.mj_header beginRefreshing];
    }
  }
}


#pragma mark -
#pragma mark 请求数据 - 下拉刷新数据
- (void)loadData
{
  // 每次刷新时重置
  self.offset = 0;
  self.page = self.offset/self.limit + 1;
  
  // 加载更多数据
  [self loadMoreData];
}

#pragma mark 请求数据 - 上拉加载数据
- (void)loadMoreData
{
  if (!self.hasMultiRequestURL) {
    [self loadMoreDataForSingle];
  } else {
    [self loadMoreDataForMultiple];
  }
}

#pragma mark 请求数据 - 上拉加载数（单个接口）
- (void)loadMoreDataForSingle
{
  WEAKSELF(weakSelf);
  
  CFCLog(@"加载前：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
  
  // 加载完数据前，其它操作
  [self viewDidLoadBeforeLoadNetworkDataOrCacheData];
  
  // 验证网络状态，无网则直接返回
  if (![CFCNetworkReachabilityUtil isNetworkAvailable]) {
    
    // 请求数据
    [self loadNetworkDataSingleThen:^(BOOL success, BOOL isCache, NSUInteger count){
      
      if (isCache) {
        
        // 加载成功
        if (success && count > 0) {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
        } else {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 是否显示EmptyDataSet空白页（默认NO）
          [weakSelf setIsEmptyDataSetShouldDisplay:YES];
          
          // 刷新加载EmptyDataSet空白页
          [weakSelf.collectionViewRefresh reloadEmptyDataSet];
          
        }
        
      } else {
        
        // 没有数据显示空白页面
        if (count > 0 || (count == 0 && weakSelf.offset > 0)) {
          [weakSelf.collectionViewRefresh setMj_footer:weakSelf.collectionViewRefreshFooter];
        } else {
          [weakSelf.collectionViewRefresh setMj_footer:nil];
        }
        
        if (count < weakSelf.limit) {
          
          // 下拉刷新控件，没有更多数据
          [weakSelf.collectionViewRefresh.mj_header endRefreshing];
          
          // 上拉刷新控件，没有更多数据
          [weakSelf.collectionViewRefresh.mj_footer endRefreshingWithNoMoreData];
          
          // 上拉刷新控件，置空（不显示已加载完成数据）
          // weakSelf.collectionViewRefresh.mj_footer = nil;
          
        } else {
          
          // 下拉刷新控件，结束刷新状态
          [weakSelf.collectionViewRefresh.mj_header endRefreshing];
          
          // 上拉刷新控件，结束刷新状态
          [weakSelf.collectionViewRefresh.mj_footer endRefreshing];
          
          // 上拉刷新控件，重新赋值
          [weakSelf.collectionViewRefreshFooter setState:MJRefreshStateIdle];
          [weakSelf.collectionViewRefresh setMj_footer:weakSelf.collectionViewRefreshFooter];
          
        }
        
        // 加载成功
        if (success && count) {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 增加偏移量
          if (count < weakSelf.limit) {
            weakSelf.offset += count;
          } else {
            weakSelf.offset += weakSelf.limit;
          }
          weakSelf.page = weakSelf.offset/weakSelf.limit + 1;
          
          // 是否只可下拉刷新1次（默认NO）
          if (weakSelf.hasRefreshOnce) {
            [weakSelf.collectionViewRefresh setMj_header:nil];
            [weakSelf.collectionViewRefresh setMj_footer:nil];
          }
          
        }  else {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 是否显示EmptyDataSet空白页（默认NO）
          [weakSelf setIsEmptyDataSetShouldDisplay:YES];
          
          // 刷新加载EmptyDataSet空白页
          [weakSelf.collectionViewRefresh reloadEmptyDataSet];
          
        }
      }
      
      CFCLog(@"加载后：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
      
      // 加载完数据后，其它操作
      [weakSelf viewDidLoadAfterLoadNetworkDataOrCacheData];
      
    }];
    
  } else {
    
    // 请求数据
    [self loadNetworkDataSingleThen:^(BOOL success, BOOL isCache, NSUInteger count){
      
      if (isCache) {
        
        // 加载成功
        if (success && count > 0) {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
        } else {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 是否显示EmptyDataSet空白页（默认NO）
          [weakSelf setIsEmptyDataSetShouldDisplay:YES];
          
          // 刷新加载EmptyDataSet空白页
          [weakSelf.collectionViewRefresh reloadEmptyDataSet];
          
        }
        
      } else {
        
        // 没有数据显示空白页面
        if (count > 0 || (count == 0 && weakSelf.offset > 0)) {
          [weakSelf.collectionViewRefresh setMj_footer:weakSelf.collectionViewRefreshFooter];
        } else {
          [weakSelf.collectionViewRefresh setMj_footer:nil];
        }
        
        if (count < weakSelf.limit) {
          
          // 下拉刷新控件，没有更多数据
          [weakSelf.collectionViewRefresh.mj_header endRefreshing];
          
          // 上拉刷新控件，没有更多数据
          [weakSelf.collectionViewRefresh.mj_footer endRefreshingWithNoMoreData];
          
          // 上拉刷新控件，置空（不显示已加载完成数据）
          // weakSelf.collectionViewRefresh.mj_footer = nil;
          
        } else {
          
          // 下拉刷新控件，结束刷新状态
          [weakSelf.collectionViewRefresh.mj_header endRefreshing];
          
          // 上拉刷新控件，结束刷新状态
          [weakSelf.collectionViewRefresh.mj_footer endRefreshing];
          
          // 上拉刷新控件，重新赋值
          [weakSelf.collectionViewRefreshFooter setState:MJRefreshStateIdle];
          [weakSelf.collectionViewRefresh setMj_footer:weakSelf.collectionViewRefreshFooter];
          
        }
        
        // 加载成功
        if (success && count > 0) {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 增加偏移量
          if (count < weakSelf.limit) {
            weakSelf.offset += count;
          } else {
            weakSelf.offset += weakSelf.limit;
          }
          weakSelf.page = weakSelf.offset/weakSelf.limit + 1;
          
          // 是否只可下拉刷新1次（默认NO）
          if (weakSelf.hasRefreshOnce) {
            [weakSelf.collectionViewRefresh setMj_header:nil];
            [weakSelf.collectionViewRefresh setMj_footer:nil];
          }
          
        } else {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 是否显示EmptyDataSet空白页（默认NO）
          [weakSelf setIsEmptyDataSetShouldDisplay:YES];
          
          // 刷新加载EmptyDataSet空白页
          [weakSelf.collectionViewRefresh reloadEmptyDataSet];
          
        }
      }
      
      CFCLog(@"加载后：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
      
      // 加载完数据后，其它操作
      [weakSelf viewDidLoadAfterLoadNetworkDataOrCacheData];
      
    }];
    
  }
}

#pragma mark 请求数据 - 上拉加载数（多个接口）
- (void)loadMoreDataForMultiple
{
  WEAKSELF(weakSelf);
  
  CFCLog(@"加载前：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
  
  // 加载完数据前，其它操作
  [self viewDidLoadBeforeLoadNetworkDataOrCacheData];
  
  // 验证网络状态，无网则直接返回
  if (![CFCNetworkReachabilityUtil isNetworkAvailable]) {
    
    // 请求数据
    [self loadNetworkDataMultipleThen:^(BOOL success, BOOL isCache, NSUInteger count){
      
      if (isCache) {
        
        // 加载成功
        if (success && count > 0) {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
        } else {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 是否显示EmptyDataSet空白页（默认NO）
          [weakSelf setIsEmptyDataSetShouldDisplay:YES];
          
          // 刷新加载EmptyDataSet空白页
          [weakSelf.collectionViewRefresh reloadEmptyDataSet];
          
        }
        
      } else {
        
        // 没有数据显示空白页面
        if (count > 0 || (count == 0 && weakSelf.offset > 0)) {
          [weakSelf.collectionViewRefresh setMj_footer:weakSelf.collectionViewRefreshFooter];
        } else {
          [weakSelf.collectionViewRefresh setMj_footer:nil];
        }
        
        if (count < weakSelf.limit) {
          
          // 下拉刷新控件，没有更多数据
          [weakSelf.collectionViewRefresh.mj_header endRefreshing];
          
          // 上拉刷新控件，没有更多数据
          [weakSelf.collectionViewRefresh.mj_footer endRefreshingWithNoMoreData];
          
          // 上拉刷新控件，置空（不显示已加载完成数据）
          // weakSelf.collectionViewRefresh.mj_footer = nil;
          
        } else {
          
          // 下拉刷新控件，结束刷新状态
          [weakSelf.collectionViewRefresh.mj_header endRefreshing];
          
          // 上拉刷新控件，结束刷新状态
          [weakSelf.collectionViewRefresh.mj_footer endRefreshing];
          
          // 上拉刷新控件，重新赋值
          [weakSelf.collectionViewRefreshFooter setState:MJRefreshStateIdle];
          [weakSelf.collectionViewRefresh setMj_footer:weakSelf.collectionViewRefreshFooter];
          
        }
        
        // 加载成功
        if (success && count) {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 增加偏移量
          if (count < weakSelf.limit) {
            weakSelf.offset += count;
          } else {
            weakSelf.offset += weakSelf.limit;
          }
          weakSelf.page = weakSelf.offset/weakSelf.limit + 1;
          
          // 是否只可下拉刷新1次（默认NO）
          if (weakSelf.hasRefreshOnce) {
            [weakSelf.collectionViewRefresh setMj_header:nil];
            [weakSelf.collectionViewRefresh setMj_footer:nil];
          }
          
        }  else {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 是否显示EmptyDataSet空白页（默认NO）
          [weakSelf setIsEmptyDataSetShouldDisplay:YES];
          
          // 刷新加载EmptyDataSet空白页
          [weakSelf.collectionViewRefresh reloadEmptyDataSet];
          
        }
      }
      
      CFCLog(@"加载后：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
      
      // 加载完数据后，其它操作
      [weakSelf viewDidLoadAfterLoadNetworkDataOrCacheData];
      
    }];
    
  } else {
    
    // 请求数据
    [self loadNetworkDataMultipleThen:^(BOOL success, BOOL isCache, NSUInteger count){
      
      if (isCache) {
        
        // 加载成功
        if (success && count > 0) {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
        } else {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 是否显示EmptyDataSet空白页（默认NO）
          [weakSelf setIsEmptyDataSetShouldDisplay:YES];
          
          // 刷新加载EmptyDataSet空白页
          [weakSelf.collectionViewRefresh reloadEmptyDataSet];
          
        }
        
      } else {
        
        // 没有数据显示空白页面
        if (count > 0 || (count == 0 && weakSelf.offset > 0)) {
          [weakSelf.collectionViewRefresh setMj_footer:weakSelf.collectionViewRefreshFooter];
        } else {
          [weakSelf.collectionViewRefresh setMj_footer:nil];
        }
        
        if (count < weakSelf.limit) {
          
          // 下拉刷新控件，没有更多数据
          [weakSelf.collectionViewRefresh.mj_header endRefreshing];
          
          // 上拉刷新控件，没有更多数据
          [weakSelf.collectionViewRefresh.mj_footer endRefreshingWithNoMoreData];
          
          // 上拉刷新控件，置空（不显示已加载完成数据）
          // weakSelf.collectionViewRefresh.mj_footer = nil;
          
        } else {
          
          // 下拉刷新控件，结束刷新状态
          [weakSelf.collectionViewRefresh.mj_header endRefreshing];
          
          // 上拉刷新控件，结束刷新状态
          [weakSelf.collectionViewRefresh.mj_footer endRefreshing];
          
          // 上拉刷新控件，重新赋值
          [weakSelf.collectionViewRefreshFooter setState:MJRefreshStateIdle];
          [weakSelf.collectionViewRefresh setMj_footer:weakSelf.collectionViewRefreshFooter];
          
        }
        
        // 加载成功
        if (success && count > 0) {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 增加偏移量
          if (count < weakSelf.limit) {
            weakSelf.offset += count;
          } else {
            weakSelf.offset += weakSelf.limit;
          }
          weakSelf.page = weakSelf.offset/weakSelf.limit + 1;
          
          // 是否只可下拉刷新1次（默认NO）
          if (weakSelf.hasRefreshOnce) {
            [weakSelf.collectionViewRefresh setMj_header:nil];
            [weakSelf.collectionViewRefresh setMj_footer:nil];
          }
          
        } else {
          
          // 刷新表格
          [weakSelf.collectionViewRefresh reloadData];
          
          // 是否显示EmptyDataSet空白页（默认NO）
          [weakSelf setIsEmptyDataSetShouldDisplay:YES];
          
          // 刷新加载EmptyDataSet空白页
          [weakSelf.collectionViewRefresh reloadEmptyDataSet];
          
        }
      }
      
      CFCLog(@"加载后：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
      
      // 加载完数据后，其它操作
      [weakSelf viewDidLoadAfterLoadNetworkDataOrCacheData];
      
    }];
    
  }
}

#pragma mark 请求数据 - 加载完数据前，其它操作，每次刷新加载数据前都会执行
- (void)viewDidLoadBeforeLoadNetworkDataOrCacheData
{
  
}

#pragma mark 请求数据 - 加载完数据后，其它操作，每次刷新加载数据后都会执行
- (void)viewDidLoadAfterLoadNetworkDataOrCacheData
{
  
}

#pragma mark 请求数据 - 单个接口 - 请求地址（子类继承实现）
- (NSString *)getRequestURLString
{
  return [CFCNetworkHTTPSessionUtil makeRequestWithURLString:nil];
}

#pragma mark 请求数据 - 单个接口 - 请求参数（子类继承实现）
- (NSMutableDictionary *)getRequestParamerter
{
  return [CFCNetworkHTTPSessionUtil makeRequestParamerterWithKeys:nil Values:nil];
}

#pragma mark 请求数据 - 单个接口 - 请求网络设置（子类继承实现）
- (void)loadNetworkRequestSettingSingle
{
  
}

#pragma mark 请求数据 - 单个接口 - 请求网络数据（请求逻辑处理）
- (void)loadNetworkDataSingleThen:(void (^)(BOOL success, BOOL isCache, NSUInteger count))then
{
  WEAKSELF(weakSelf);
  
  // 请求数据是否成功
  __block BOOL isCache = NO;
  __block BOOL isSuccess = NO;
  __block NSUInteger listCount = 0; // 请求到的数据数量
  __block NSString *showMessage = self.isShowLoadingHUD ? self.showLoadingMessage : nil;
  
  // 初始化设置
  [self loadNetworkRequestSettingSingle];
  
  // 请求地址与参数
  NSString *url = [weakSelf getRequestURLString];
  NSMutableDictionary *params = [weakSelf getRequestParamerter];
  
  // 验证请求连接的正确性
  if ([CFCSysUtil validateStringEmpty:url]) {
    // 刷新界面
    !then ?: then(isSuccess, isCache, listCount);
    return ;
  }
  
  // 数据分页处理
  if (self.hasPage) {
    [params setObject:[NSNumber numberWithInteger:_page].stringValue forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:_limit].stringValue forKey:@"limit"];
    [params setObject:[NSNumber numberWithInteger:_offset].stringValue forKey:@"offset"];
  }
  CFCLog(@"\n请求地址：%@ \n请求参数：%@", url, params);
  
  // 请求网络数据
  switch (self.requestMethod) {
      // 网络GET请求
    case CFCRequestMethodGET: {
      
      _requestOfSingle = [CFCNetworkHTTPSessionUtil GET:url parameters:params responseCache:^(id responseCache) {
        
        // 是否需要加载缓存（默认NO）
        if (self->_hasCacheData && !self->_offset) {
          
          // 设置缓存标识
          isCache = YES;
          
          // 加载解析缓存数据
          NSMutableArray *responseTableData = [weakSelf loadNetworkDataOrCacheDataSingle:responseCache isCacheData:YES];
          
          // 更新请求数据状态（用于刷新数据表格）
          listCount = responseTableData.count;
          if (listCount > 0) {
            isSuccess = YES;
            CFCLog(@"加载解析缓存数据成功");
          } else {
            isSuccess = YES;
            CFCLog(@"没有更多数据");
          }
          
          // 刷新界面
          !then ?: then(isSuccess, isCache, listCount);
          
        }
        
      } cacheTimeInSeconds:CACHE_TIME_IN_SECONDS_NONE success:^(id responseObject) {
        
        // 设置缓存标识
        isCache = NO;
        
        // 加载解析网络数据
        NSMutableArray *responseTableData = [weakSelf loadNetworkDataOrCacheDataSingle:responseObject isCacheData:NO];
        
        // 更新请求数据状态（用于刷新数据表格）
        listCount = responseTableData.count - (weakSelf.page-1)*weakSelf.limit;
        if (listCount > 0) {
          isSuccess = YES;
          CFCLog(@"加载请求网络数据成功");
        } else {
          isSuccess = YES;
          CFCLog(@"没有更多数据");
        }
        
        // 刷新界面
        !then ?: then(isSuccess, isCache, listCount);
        
        // 第一次加载数据后禁止显示菊花
        self.isShowLoadingHUD = NO;
        
      } failure:^(NSError *error) {
        
        CFCLog(@"加载请求网络数据异常：%@", error);
        
        // 设置缓存标识
        isCache = NO;
        
        // 刷新界面
        !then ?: then(isSuccess, isCache, listCount);
        
        // 第一次加载数据后禁止显示菊花
        self.isShowLoadingHUD = NO;
        
      } showMessage:showMessage showProgressHUD:self.isShowLoadingHUD showProgressView:self.view isHideErrorMessage:YES];
      
    }
      // 网络POST请求
    case CFCRequestMethodPOST: {
      
      _requestOfSingle = [CFCNetworkHTTPSessionUtil POST:url parameters:params responseCache:^(id responseCache) {
        
        // 是否需要加载缓存（默认NO）
        if (self->_hasCacheData && !self->_offset) {
          
          // 设置缓存标识
          isCache = YES;
          
          // 加载解析缓存数据
          NSMutableArray *responseTableData = [weakSelf loadNetworkDataOrCacheDataSingle:responseCache isCacheData:YES];
          
          // 更新请求数据状态（用于刷新数据表格）
          listCount = responseTableData.count;
          if (listCount > 0) {
            isSuccess = YES;
            CFCLog(@"加载解析缓存数据成功");
          } else {
            isSuccess = YES;
            CFCLog(@"没有更多数据");
          }
          
          // 刷新界面
          !then ?: then(isSuccess, isCache, listCount);
          
        }
        
      } cacheTimeInSeconds:CACHE_TIME_IN_SECONDS_NONE success:^(id responseObject) {
        
        // 设置缓存标识
        isCache = NO;
        
        // 加载解析网络数据
        NSMutableArray *responseTableData = [weakSelf loadNetworkDataOrCacheDataSingle:responseObject isCacheData:NO];
        
        // 更新请求数据状态（用于刷新数据表格）
        listCount = responseTableData.count - (weakSelf.page-1)*weakSelf.limit;
        if (listCount > 0) {
          isSuccess = YES;
          CFCLog(@"加载请求网络数据成功");
        } else {
          isSuccess = YES;
          CFCLog(@"没有更多数据");
        }
        
        // 刷新界面
        !then ?: then(isSuccess, isCache, listCount);
        
        // 第一次加载数据后禁止显示菊花
        self.isShowLoadingHUD = NO;
        
      } failure:^(NSError *error) {
        
        CFCLog(@"加载请求网络数据异常：%@", error);
        
        // 设置缓存标识
        isCache = NO;
        
        // 刷新界面
        !then ?: then(isSuccess, isCache, listCount);
        
        // 第一次加载数据后禁止显示菊花
        self.isShowLoadingHUD = NO;
        
      } showMessage:showMessage showProgressHUD:self.isShowLoadingHUD showProgressView:self.view isHideErrorMessage:YES];
      
    }
    default: {
      return;
    }
  }
  
  
}


#pragma mark 请求数据 - 单个接口 - 请求网络数据或加载缓存（子类继承实现处理过程）
- (NSMutableArray *)loadNetworkDataOrCacheDataSingle:(id)responseDataOrCacheData isCacheData:(BOOL)isCacheData
{
  
  return nil;
}

#pragma mark 请求数据 - 多个接口 - 请求子类（子类继承实现）
- (NSArray<CFCBaseRequest *> *)getRequestArrayMultiple
{
  // 请求地址与参数
  NSString *url = [self getRequestURLString];
  NSMutableDictionary *params = [self getRequestParamerter];
  
  // 数据分页处理
  if (self.hasPage) {
    [params setObject:[NSNumber numberWithInteger:_page].stringValue forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:_limit].stringValue forKey:@"limit"];
    [params setObject:[NSNumber numberWithInteger:_offset].stringValue forKey:@"offset"];
  }
  CFCLog(@"\n请求地址：%@ \n请求参数：%@", url, params);
  
  // 网络请求类
  CFCBaseRequest *request = [[CFCBaseRequest alloc] initWithRequestUrl:url parameters:params];
  request.method = self.requestMethod;
  request.animatingText = nil;
  request.isHideErrorMessage = YES;
  request.cacheTimeInSeconds = CACHE_TIME_IN_SECONDS_NONE;
  
  return [NSArray<CFCBaseRequest *> arrayWithObject:request];
}

#pragma mark 请求数据 - 多个接口 - 请求批量（子类继承实现）
- (CFCBaseBatchRequest *)getRequestBatchMultiple
{
  NSArray<CFCBaseRequest *> *requestArray = [self getRequestArrayMultiple];
  
  // 数据分页处理
  if (self.hasPage) {
    for (CFCBaseRequest *request in requestArray) {
      NSString *url = request.url;
      NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:request.parameters];
      [params setObject:[NSNumber numberWithInteger:self->_page].stringValue forKey:@"page"];
      [params setObject:[NSNumber numberWithInteger:self->_limit].stringValue forKey:@"limit"];
      [params setObject:[NSNumber numberWithInteger:self->_offset].stringValue forKey:@"offset"];
      [request setUrl:url];
      [request setParameters:params];
      CFCLog(@"\n请求地址：%@ \n请求参数：%@", url, params);
    }
  }
  
  // 批量请求类
  CFCBaseBatchRequest *requestPageService = [[CFCBaseBatchRequest alloc] initWithRequestArray:requestArray];
  requestPageService.animatingText = self.isShowLoadingHUD ? self.showLoadingMessage : nil;
  
  // 返回批量请求数据接口
  return requestPageService;
}

#pragma mark 请求数据 - 多个接口 - 请求网络设置（子类继承实现）
- (void)loadNetworkRequestSettingMultiple
{
  
}

#pragma mark 请求数据 - 多个接口 - 请求网络数据（请求逻辑处理）
- (void)loadNetworkDataMultipleThen:(void (^)(BOOL success, BOOL isCache, NSUInteger count))then
{
  WEAKSELF(weakSelf);
  
  // 请求数据是否成功
  __block BOOL isCache = NO;
  __block BOOL isSuccess = NO;
  __block NSUInteger listCount = 0; // 请求到的数据数量
  
  // 初始化设置
  [self loadNetworkRequestSettingMultiple];
  
  // 请求地址与参数
  CFCBaseBatchRequest *requestPageService = [weakSelf getRequestBatchMultiple];
  
  // 保存请求接口
  _requestOfMultiple = requestPageService;
  
  // 请求网络数据
  [requestPageService startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
    
    // 设置缓存标识
    isCache = NO;
    
    // 加载解析网络数据
    NSMutableArray *responseTableData = [weakSelf loadNetworkDataOrCacheDataMultiple:batchRequest isCacheData:NO];
    
    // 更新请求数据状态（用于刷新数据表格）
    listCount = responseTableData.count - (weakSelf.page-1)*weakSelf.limit;
    if (listCount > 0) {
      isSuccess = YES;
      CFCLog(@"加载请求网络数据成功");
    } else {
      isSuccess = YES;
      CFCLog(@"没有更多数据");
    }
    
    // 刷新界面
    !then ?: then(isSuccess, isCache, listCount);
    
    // 第一次加载数据后禁止显示菊花
    self.isShowLoadingHUD = NO;
    
  } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
    
    CFCLog(@"加载请求网络数据异常：%@", batchRequest.failedRequest.error);
    
    // 设置缓存标识
    isCache = NO;
    
    // 刷新界面
    !then ?: then(isSuccess, isCache, listCount);
    
    // 第一次加载数据后禁止显示菊花
    self.isShowLoadingHUD = NO;
    
  }];
  
}

#pragma mark 请求数据 - 多个接口 - 请求网络数据或加载缓存（子类继承实现处理过程）
- (NSMutableArray *)loadNetworkDataOrCacheDataMultiple:(YTKBatchRequest * _Nonnull)batchRequest isCacheData:(BOOL)isCacheData
{
  
  return nil;
}


#pragma mark -
#pragma mark 创建界面表格
- (void)createUIRefreshCollection:(BOOL)force
{
  // 是否创建表格
  if (!_hasCollectionViewRefresh) {
    return;
  }
  
  // 表格已经存在则无需创建，直接返回；否则强制创建表格
  if (self.collectionViewRefresh && !force) {
    return;
  }
  
  // 强制创建表格
  if (force && self.collectionViewRefresh) {
    [self.collectionViewRefresh removeFromSuperview];
  }
  
  // 表格已经存在则无需创建，直接返回；否则强制创建表格
  if (self.collectionViewRefresh && !force) {
    return;
  }
  
  // 创建表格
  {
    // 设置表格
    UICollectionViewLayout *layout = [self collectionViewLayout];
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.width, self.view.height);
    self.collectionViewRefresh = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [self.view addSubview:self.collectionViewRefresh];
    [self.collectionViewRefresh setDelegate:self];
    [self.collectionViewRefresh setDataSource:self];
    [self.collectionViewRefresh setShowsVerticalScrollIndicator:YES];
    [self.collectionViewRefresh setBackgroundColor:COLOR_TABLEVIEW_BACK_VIEW_BACKGROUND_DEFAULT];
    
    // 空白页展示
    [self.collectionViewRefresh setEmptyDataSetSource:self];
    [self.collectionViewRefresh setEmptyDataSetDelegate:self];
    
    // UICollectionView 支持侧滑返回
    [self tz_addPopGestureToView:self.collectionViewRefresh];
    
    // 计算表格位置
    switch ([self preferredNavigationBarType]) {
        // 系统导航栏
      case CFCNavBarTypeDefault: {
        if ([self prefersNavigationBarHidden]) {
          // 系统导航栏已隐藏-自定义导航栏UINavigationBar
          [self.collectionViewRefresh setFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT)];
          if (IS_IPHONE_X_OR_GREATER) {
            [self.collectionViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.view.mas_left);
              make.right.equalTo(self.view.mas_right);
              if (@available(iOS 11.0, *)) {
                if (self.isAutoLayoutSafeAreaTop) {
                  make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
                } else {
                  make.top.equalTo(self.view.mas_top).with.offset(0.0);
                }
                if (self.isAutoLayoutSafeAreaBottom) {
                  make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                } else {
                  make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
                }
              } else {
                make.top.equalTo(self.view.mas_top).with.offset(0.0);
                make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
              }
            }];
          } else {
            [self.collectionViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.view.mas_left);
              make.right.equalTo(self.view.mas_right);
              make.top.equalTo(self.mas_topLayoutGuide).with.offset(0.0);
              make.bottom.equalTo(self.mas_bottomLayoutGuide).with.offset(0.0);
            }];
          }
        } else {
          // 系统导航栏未隐藏-自定义导航栏TitleView
          [self.collectionViewRefresh setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_NAVIGATION_BAR_HEIGHT)];
          if (IS_IPHONE_X_OR_GREATER) {
            [self.collectionViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.view.mas_left);
              make.right.equalTo(self.view.mas_right);
              if (@available(iOS 11.0, *)) {
                if (self.isAutoLayoutSafeAreaTop) {
                  make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
                } else {
                  make.top.equalTo(self.view.mas_top).with.offset(0.0);
                }
                if (self.isAutoLayoutSafeAreaBottom) {
                  make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                } else {
                  make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
                }
              } else {
                make.top.equalTo(self.view.mas_top).with.offset(0.0);
                make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
              }
            }];
          } else {
            [self.collectionViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.view.mas_left);
              make.right.equalTo(self.view.mas_right);
              make.top.equalTo(self.mas_topLayoutGuide).with.offset(0.0);
              make.bottom.equalTo(self.mas_bottomLayoutGuide).with.offset(0.0);
            }];
          }
        }
        break;
      }
        // 自定义导航栏
      case CFCNavBarTypeCustom: {
        if ([self prefersNavigationBarHidden]) {
          // 系统导航栏已隐藏-自定义导航栏UINavigationBar
          [self.collectionViewRefresh setFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT)];
          if (IS_IPHONE_X_OR_GREATER) {
            [self.collectionViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.view.mas_left);
              make.right.equalTo(self.view.mas_right);
              if (@available(iOS 11.0, *)) {
                if (self.isAutoLayoutSafeAreaTop) {
                  make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
                } else {
                  make.top.equalTo(self.view.mas_top).with.offset(0.0);
                }
                if (self.isAutoLayoutSafeAreaBottom) {
                  make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                } else {
                  make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
                }
              } else {
                make.top.equalTo(self.view.mas_top).with.offset(0.0);
                make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
              }
            }];
          } else {
            [self.collectionViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.view.mas_left);
              make.right.equalTo(self.view.mas_right);
              make.top.equalTo(self.mas_topLayoutGuide).with.offset(0.0);
              make.bottom.equalTo(self.mas_bottomLayoutGuide).with.offset(0.0);
            }];
          }
        } else {
          // 系统导航栏未隐藏-自定义导航栏TitleView
          [self.collectionViewRefresh setFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_NAVIGATION_BAR_HEIGHT)];
          if (IS_IPHONE_X_OR_GREATER) {
            [self.collectionViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.view.mas_left);
              make.right.equalTo(self.view.mas_right);
              if (@available(iOS 11.0, *)) {
                if (self.isAutoLayoutSafeAreaTop) {
                  make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
                } else {
                  make.top.equalTo(self.view.mas_top).with.offset(0.0);
                }
                if (self.isAutoLayoutSafeAreaBottom) {
                  make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                } else {
                  make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
                }
              } else {
                make.top.equalTo(self.view.mas_top).with.offset(0.0);
                make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
              }
            }];
          } else {
            [self.collectionViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.view.mas_left);
              make.right.equalTo(self.view.mas_right);
              make.top.equalTo(self.mas_topLayoutGuide).with.offset(0.0);
              make.bottom.equalTo(self.mas_bottomLayoutGuide).with.offset(0.0);
            }];
          }
        }
        break;
      }
      default: {
        break;
      }
    }
    
    // 设置背景
    UIView *backgroundView = [[UIView alloc] init];
    [backgroundView setBackgroundColor:COLOR_TABLEVIEW_BACK_VIEW_BACKGROUND_DEFAULT];
    [self.collectionViewRefresh setBackgroundView:backgroundView];
    
    // 下拉刷新
    if (self.hasRefreshHeader) {
      CFCRefreshHeader *refreshHeader = [CFCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
      [refreshHeader setTitle:CFCRefreshAutoHeaderIdleText forState:MJRefreshStateIdle];
      [refreshHeader setTitle:CFCRefreshAutoHeaderPullingText forState:MJRefreshStatePulling];
      [refreshHeader setTitle:CFCRefreshAutoHeaderRefreshingText forState:MJRefreshStateRefreshing];
      [refreshHeader.stateLabel setTextColor:COLOR_HEXSTRING(CFCRefreshAutoHeaderColor)];
      [refreshHeader.stateLabel setFont:[UIFont systemFontOfSize:CFC_AUTOSIZING_FONT(CFCRefreshAutoFooterFontSize)]];
      [refreshHeader setBackgroundColor:COLOR_TABLEVIEW_BACK_VIEW_BACKGROUND_DEFAULT];
      [self setCollectionViewRefreshHeader:refreshHeader];
      [self.collectionViewRefresh setMj_header:refreshHeader];
    }
    
    // 上拉加载
    if (self.hasRefreshFooter) {
      CFCRefreshFooter *refreshFooter = [CFCRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
      [refreshFooter setTitle:CFCRefreshAutoFooterIdleText forState:MJRefreshStateIdle];
      [refreshFooter setTitle:CFCRefreshAutoFooterRefreshingText forState:MJRefreshStateRefreshing];
      [refreshFooter setTitle:CFCRefreshAutoFooterNoMoreDataText forState:MJRefreshStateNoMoreData];
      [refreshFooter.stateLabel setTextColor:COLOR_HEXSTRING(CFCRefreshAutoFooterColor)];
      [refreshFooter.stateLabel setFont:[UIFont systemFontOfSize:CFC_AUTOSIZING_FONT(CFCRefreshAutoFooterFontSize)]];
      [refreshFooter setBackgroundColor:COLOR_TABLEVIEW_BACK_VIEW_BACKGROUND_DEFAULT];
      [self setCollectionViewRefreshFooter:refreshFooter];
    }
    
    // 设置 UICollectionView
    [self collectionViewRefreshSetting:self.collectionViewRefresh];
    
    // 必须被注册到 UITableView 中
    [self collectionViewRefreshRegisterClass:self.collectionViewRefresh];
  }
  
}


#pragma mark 设置 UICollectionView（子类继承实现）
- (void)collectionViewRefreshSetting:(UICollectionView *)collectionView
{
  
}

#pragma mark 注册 UICollectionView（子类继承实现）
- (void)collectionViewRefreshRegisterClass:(UICollectionView *)collectionView
{
  // 注册 UICollectionReusableView Section Header（必须）
  [self.collectionViewRefresh registerClass:[CFCCollectionSectionNULLHeaderView class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:CELL_IDENTIFIER_COLLECTION_SECTION_NULL_HEADER];
  
  // 注册 UICollectionReusableView Section Footer（必须）
  [self.collectionViewRefresh registerClass:[CFCCollectionSectionNULLFooterView class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:CELL_IDENTIFIER_COLLECTION_SECTION_NULL_FOOTER];
}

#pragma mark 设置 CFCCollectionViewLayoutType 布局
- (CFCCollectionViewLayoutType)collectionViewLayoutType
{
  return CFCCollectionViewLayoutTypeDefault;
}

#pragma mark 设置 CFCCollectionViewLayoutType 布局
- (UICollectionViewLayout *)collectionViewLayout
{
  switch ([self collectionViewLayoutType]) {
      // 流式布局
      case CFCCollectionViewLayoutTypeFlowLayout: {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        return flowLayout;
      }
      // 瀑布布局
      case CFCCollectionViewLayoutTypeWaterFallLayout: {
        CFCCollectionRefreshViewWaterFallLayout *flowLayout = [[CFCCollectionRefreshViewWaterFallLayout alloc] init];
        flowLayout.delegate = self;
        return flowLayout;
      }
      // 默认布局
    default: {
      UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
      flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
      return flowLayout;
    }
  }
}

#pragma mark 数据模型
- (NSMutableArray *)collectionViewDataRefresh
{
  if (!_collectionViewDataRefresh) {
    _collectionViewDataRefresh = [NSMutableArray array];
  }
  return _collectionViewDataRefresh;
}


#pragma mark -
#pragma mark 销毁释放资源
- (void)dealloc
{
  if (self.requestOfSingle) {
    [self.requestOfSingle stop];
  }
  if (self.requestOfMultiple) {
    [self.requestOfMultiple stop];
  }
}


#pragma mark -
#pragma mark 设置导航条样式类型
- (CFCNavBarType)preferredNavigationBarType
{
  return CFCNavBarTypeDefault;
}


#pragma mark - UICollectionViewDataSource
#pragma mark 设置组数（默认1组）（可选实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 0;
}

#pragma mark 每一个分组中 Cell 的个数（必须实现）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 0;
}

#pragma mark 每一个分组 Cell 实例，使用dequeueReusableCellWithReuseIdentifier:forIndexPath:方法复用（必须实现）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

#pragma mark 返回组头/组尾视图，使用dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:方法复用（可选实现）
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
  if (kind == UICollectionElementKindSectionHeader) {
    
    CFCCollectionSectionNULLHeaderView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                               withReuseIdentifier:CELL_IDENTIFIER_COLLECTION_SECTION_NULL_HEADER
                                                                                                      forIndexPath:indexPath];
    return sectionHeaderView;
    
  } else if (kind == UICollectionElementKindSectionFooter) {
    
    CFCCollectionSectionNULLFooterView *sectionFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                               withReuseIdentifier:CELL_IDENTIFIER_COLLECTION_SECTION_NULL_FOOTER
                                                                                                      forIndexPath:indexPath];
    return sectionFooterView;
    
  }
  
  return nil;
}

#pragma mark 设置某个 Cell 是否可以移动（可选实现）
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
  return NO;
}

#pragma mark 移动 Cell 的时候，会调用这个方法（可选实现）
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
  
}


#pragma mark - UICollectionViewDelegate
#pragma mark 选中某个 Cell 时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark 取消选中某个 Cell 时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}


#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark 动态设置每个 Item（Cell）的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(collectionView.bounds.size.width, 45);
}

#pragma mark 动态设置 Cell 的上下左右边界缩进
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark 动态设置 Cell 行间的间距最小距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return 0;
}

#pragma mark 动态设置 Cell 列间的间距最小距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
  return 0;
}

#pragma mark 动态设置组头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
  return CGSizeMake(collectionView.bounds.size.width, FLOAT_MIN);
}

#pragma mark 动态设置组尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
  return CGSizeMake(collectionView.bounds.size.width, FLOAT_MIN);
}


#pragma mark -
#pragma mark CFCCollectionRefreshViewWaterFallLayoutDelegate

#pragma mark 自定义表格每一个分组的列数
- (NSInteger)numberOfColumnsInSectionForIndexPath:(NSIndexPath *)indexPath
{
  return 1;
}

#pragma mark 自定义表格每一行的高度
- (CGFloat)heightOfCellItemForCollectionViewAtIndexPath:(NSIndexPath *)indexPath
{
  return 50.0f;
}

#pragma mark 自定义表格的 SectionHeader 的高度
- (CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath
{
  return FLOAT_MIN;
}

#pragma mark 自定义表格的 SectionFooter 的高度
- (CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath
{
  return FLOAT_MIN;
}



@end
