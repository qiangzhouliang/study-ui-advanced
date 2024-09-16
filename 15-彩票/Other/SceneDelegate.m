//
//  SceneDelegate.m
//  15-彩票
//
//  Created by swan on 2024/9/12.
//

#import "SceneDelegate.h"
#import "SWTabBarController.h"
#import "SWGuideCollectionViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    


    // 1. 创建窗口并且指定大小
    UIWindowScene *windowScene = (UIWindowScene*)scene;
    
    self.window = [[UIWindow alloc] initWithFrame: KScreenSize];
    [self.window setWindowScene: windowScene];

    // 创建 tabbarController
    SWTabBarController *tabbarVC = [self pickViewController];

    // 2.2 设置为窗口的根控制器
    [self.window setRootViewController: tabbarVC];    // set root view controller
    // 3. 将窗口作为应用程序的主窗口，并设置为可见
    [self.window makeKeyAndVisible];    // show it

    // 把当前版本保存到沙盒当中
    [SWAppTool saveAppVersion];
}

-(UIViewController *)pickViewController{
    // 判断 沙盒版本号 是不是 和当前程序版本号（info）一致
    if ([[SWAppTool loadSaveAppVersion] isEqualToString:[SWAppTool loadAppVersion]] ) {
        // 如果一致 显示 tabbarController
        SWLog(@"显示tabbarController");
        return [[SWTabBarController alloc] init];
    } else {
        // 如果不一致 显示 新特性
        SWLog(@"显示新特性");
        return [[SWGuideCollectionViewController alloc] init];
    }

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
