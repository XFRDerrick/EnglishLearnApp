//
//  AppDelegate.m
//  LearnEnglish
//
//  Created by universe on 2016/12/30.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "AppDelegate.h"
#import "UNMainTableViewController.h"
#import "UNLeftMenuController.h"
#import "RESideMenu.h"

#import "UNUserLoginRegisterController.h"

@interface AppDelegate ()<RESideMenuDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册登录sdk
    [Bmob registerWithAppKey:@"6b1457b3c88869499d3ce8df61ba4edb"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //判断是否登录 ，没有登录显示登录欢迎界面
    BmobUser *bUser = [BmobUser currentUser];
    if (bUser) {//已经登录 进行操作
        self.window.rootViewController = [self setWindowRootVCWithMain];
        
    }else{
        //对象为空时，可打开用户注册界面 欢迎界面
        UNUserLoginRegisterController *lrVC = [[UNUserLoginRegisterController alloc] init];
        lrVC.enterHidden = NO;
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:lrVC];
        
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (RESideMenu *)setWindowRootVCWithMain{

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[UNMainTableViewController alloc] initWithStyle:UITableViewStylePlain]];
    
    UNLeftMenuController *leftMenuViewController = [[UNLeftMenuController alloc] init];
    
    RESideMenu *sideMenuVC = [[RESideMenu alloc] initWithContentViewController:navigationController leftMenuViewController:[[UINavigationController alloc] initWithRootViewController:leftMenuViewController] rightMenuViewController:nil];
    
    sideMenuVC.backgroundImage = [UIImage imageNamed:@"leftVC_BG"];
    
    sideMenuVC.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuVC.delegate = self;
    sideMenuVC.contentViewShadowColor = [UIColor blackColor];
    sideMenuVC.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuVC.contentViewShadowOpacity = 0.6;
    sideMenuVC.contentViewShadowRadius = 12;
    sideMenuVC.contentViewShadowEnabled = YES;
    return sideMenuVC;
//    self.window.rootViewController = sideMenuVC;
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}
#pragma mark - 
#pragma mark AppDelegate

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
