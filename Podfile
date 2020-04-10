# 最低版本
platform :ios, '9.0'

# 禁止警告
inhibit_all_warnings!

# 公有仓库
source 'https://github.com/CocoaPods/Specs.git'
# 私有仓库
# source 'https://git.coding.net/PrivateSpecs.git'

target 'YOURFRAME' do
  
  # 公有仓库 - 缓存管理框架
  pod 'YYCache', '~>1.0.4'
  # 公有仓库 - 自动布局框架
  pod 'Masonry', '~> 1.1.0'
  # 公有仓库 - 下拉刷新框架
  pod 'MJRefresh', '~> 3.3.1'
  # 公有仓库 - 离散网络请求框架
  pod 'YTKNetwork', '~>2.1.4', :inhibit_warnings => true
  # 公有仓库 - 集约网络请求框架
  pod 'AFNetworking', '~>3.2.1', :inhibit_warnings => true
  # 公有仓库 - 图片加载框架
  pod 'SDWebImage', '~> 5.5.2'
  # 公有仓库 - 字典和模型转换框架
  pod 'MJExtension', '~> 3.2.1'
  # 公有仓库 - 弹出进度提示框
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SVProgressHUD', '~> 2.2.5'
  # 公有仓库 - 空白页展示
  pod 'DZNEmptyDataSet', '~>1.8.1'
  # 公有仓库 - 广告轮播框架
  pod 'SDCycleScrollView', '~> 1.80'
  # 公有仓库 - 自动计算高度框架
  pod 'UITableView+FDTemplateLayoutCell', '~>1.6'
  # 公有仓库 - 让UIScrollView的滑动和系统侧滑手势并存，例如：在查看地图界面同时支持地图的滑动和侧滑返回。注：和FDFullscreenPopGesture库不冲突
  pod 'TZScrollViewPopGesture', '~> 1.0.6'
  # 公有仓库 - 导航栏按钮位置偏移的解决方案
  pod 'UINavigation-SXFixSpace', '~> 1.2.4'
  
end

# 删除警告
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end
