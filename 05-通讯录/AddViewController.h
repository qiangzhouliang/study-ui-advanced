//
//  AddViewController.h
//  05-通讯录
//
//  Created by swan on 2024/9/8.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@class AddViewController;
NS_ASSUME_NONNULL_BEGIN

@protocol AddViewControllerDelegate <NSObject>

@optional
-(void)AddViewController:(AddViewController *) addViewController withContact:(Contact *)contact;

@end

@interface AddViewController : UIViewController
@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
