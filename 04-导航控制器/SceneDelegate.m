//
//  SceneDelegate.m
//  04-导航控制器
//
//  Created by swan on 2024/9/6.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import "Controllers/HMRedViewController.h"
#import "Controllers/HMGreenViewController.h"
#import "Controllers/HMBlueViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // 1. 创建窗口并且指定大小
    UIWindowScene *windowScene = (UIWindowScene*)scene;
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [self.window setWindowScene: windowScene];
    
    // 创建 红色 控制器交给导航控制器管理
    HMRedViewController *redVc = [HMRedViewController new];
     
    // 2. 设置窗口的根控制器
    // 2.1 创建控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:redVc];
    
    
    // 2.2 设置为窗口的根控制器
    [self.window setRootViewController: nav];
    
    // 3. 将窗口作为应用程序的主窗口，并设置为可见
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
