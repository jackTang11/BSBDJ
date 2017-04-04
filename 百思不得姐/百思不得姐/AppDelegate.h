//
//  AppDelegate.h
//  百思不得姐
//
//  Created by jack_tang on 17/4/4.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

