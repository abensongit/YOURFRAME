//
// Created by Chenyu Lan on 10/30/14.
// Copyright (c) 2014 Fenbi. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<YTKNetwork/YTKNetwork.h>)
#import <YTKNetwork/YTKNetwork.h>
#else
#import "YTKNetwork.h"
#endif

@interface YTKBaseRequest (AnimatingAccessory)

@property (weak, nonatomic) UIView *animatingView;

@property (strong, nonatomic) NSString *animatingText;

@end
