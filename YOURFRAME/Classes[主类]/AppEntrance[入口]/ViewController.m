//
//  ViewController.m
//  YOURFRAME
//
//  Created by sunshine on 2019/9/30.
//  Copyright © 2019 sunshine. All rights reserved.
//

#import "ViewController.h"
#import "AppHomeViewController.h"
#import "AppSettingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark 添加子控制器
- (void)addChildControllers
{
  // 首页
  [self addChildNavigationController:[CFCNavigationController class]
                  rootViewController:[AppHomeViewController class]
                     navigationTitle:STR_NAVIGATION_BAR_TITLE_HOME
                     tabBarItemTitle:STR_TAB_BAR_ITEM_NAME_HOME
               tabBarNormalImageName:ICON_TAB_BAR_ITEM_HOME_NORMAL
               tabBarSelectImageName:ICON_TAB_BAR_ITEM_HOME_SELECT
                   tabBarItemEnabled:YES];
  // 我的
  [self addChildNavigationController:[CFCNavigationController class]
                  rootViewController:[AppSettingViewController class]
                     navigationTitle:STR_NAVIGATION_BAR_TITLE_SETTING
                     tabBarItemTitle:STR_TAB_BAR_ITEM_NAME_SETTING
               tabBarNormalImageName:ICON_TAB_BAR_ITEM_SETTING_NORMAL
               tabBarSelectImageName:ICON_TAB_BAR_ITEM_SETTING_SELECT
                   tabBarItemEnabled:YES];
}


@end
