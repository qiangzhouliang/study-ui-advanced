//
//  SceneDelegate.m
//  03-加载自定义控制器
//
//  Created by swan on 2024/9/6.
//

#import "SceneDelegate.h"
#import "HMViewController.h"
#import "HMXibViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    // 1. 创建窗口并且指定大小
    UIWindowScene *windowScene = (UIWindowScene*)scene;
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [self.window setWindowScene: windowScene];
     
    // 2. 设置窗口的根控制器
//    [self code];
//    [self storyboard];
    [self xib];
    
    // 3. 将窗口作为应用程序的主窗口，并设置为可见
    [self.window makeKeyAndVisible];    // show it

}

#pragma mark - 通过 xib 创建控制器
- (void)xib{
    // 1. 名称没有规律
//    HMXibViewController *xibVc = [[HMXibViewController alloc] initWithNibName:@"HMMMD" bundle:nil];
    
    // 2. 名称与控制器的类名相似
//    HMXibViewController *xibVc = [[HMXibViewController alloc] init];
    
    // 3. 名称与控制器的类名完全一样
    HMXibViewController *xibVc = [[HMXibViewController alloc] init];
    
    
    [self.window setRootViewController: xibVc];    // set root view controller
}

#pragma mark - 通过storyboard创建控制器
- (void)storyboard{
    // 1 加载storyboard文件
    UIStoryboard *hmBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    // 2. 从 storyboard 文件中实例化控制器
    UIViewController *vc = [hmBoard instantiateInitialViewController];
//    UIViewController *vc2 = [hmBoard instantiateViewControllerWithIdentifier:@"blue"];
    
    [self.window setRootViewController: vc];    // set root view controller
}

#pragma mark - 通过纯代码创建控制器
- (void)code{
    // 2.1 创建控制器
    HMViewController *viewController = [[HMViewController alloc] init]; // need import ViewController.h head file
    // 2.2 设置为窗口的根控制器
    [self.window setRootViewController: viewController];    // set root view controller
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
