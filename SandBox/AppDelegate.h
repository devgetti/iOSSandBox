//
//  AppDelegate.h
//  SandBox
//
//  Created by akosuge on 2013/08/01.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stats.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIBackgroundTaskIdentifier _bgTask;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Stats * stats;

@end
