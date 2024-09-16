//
//  SceneDelegate.m
//  06-UITableBarViewController
//
//  Created by swan on 2024/9/9.
//

#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // 1. 创建窗口并且指定大小
    UIWindowScene *windowScene = (UIWindowScene*)scene;
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [self.window setWindowScene: windowScene];
     
    // 2. 初始化 tabbarcontroller
    // 2.1 创建控制器
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    // 创建子控制器
    UIViewController *v1 = [[UIViewController alloc] init];
    UIViewController *v2 = [[UIViewController alloc] init];
    UIViewController *v3 = [[UIViewController alloc] init];
    
    // 设置背景色
    v1.view.backgroundColor = UIColor.redColor;
    v2.view.backgroundColor = UIColor.greenColor;
    v3.view.backgroundColor = UIColor.blueColor;
    
    // 设置内容
    v1.tabBarItem.title = @"联系人";
    v1.tabBarItem.image = [UIImage systemImageNamed:@"person.fill"];
    
    v2.tabBarItem.title = @"消息";
    v2.tabBarItem.image = [UIImage systemImageNamed:@"person.fill"];
    
    v3.tabBarItem.title = @"我的";
    v3.tabBarItem.image = [UIImage systemImageNamed:@"person.fill"];
    
    // 设置提醒内容
    v1.tabBarItem.badgeValue = @"998";
    
    [tabbarController addChildViewController:v1];
    [tabbarController addChildViewController:v2];
    [tabbarController addChildViewController:v3];
    
    
    tabbarController.tabBar.backgroundColor = UIColor.grayColor;
    // 2.2 设置为窗口的根控制器
    [self.window setRootViewController: tabbarController];
    
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
