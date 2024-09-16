//
//  EditViewController.h
//  05-通讯录
//
//  Created by swan on 2024/9/8.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@class EditViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol EditViewControllerDelegate <NSObject>

@optional
-(void)EditViewController:(EditViewController *) editViewController withContact:(Contact *)contact;

@end


@interface EditViewController : UIViewController

@property (nonatomic, strong) Contact *contact;

@property (nonatomic, weak) id<EditViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
