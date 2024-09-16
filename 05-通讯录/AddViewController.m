//
//  AddViewController.m
//  05-通讯录
//
//  Created by swan on 2024/9/8.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.name addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.number addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    // 监听添加按钮的点击事件
    [self.addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 让姓名文本框成为第一响应者
    [self.name becomeFirstResponder];
}

/// 添加按钮的点击事件
-(void)addClick{
    // 判断代理方法是不是能够响应
    if ([self.delegate respondsToSelector:@selector(AddViewController:withContact:)]) {
        Contact *contact = [Contact new];
        contact.name = self.name.text;
        contact.number = self.number.text;
        [self.delegate AddViewController:self withContact:contact];
    }
    
    // 返回上一个控制器（联系人列表）
    [self.navigationController popViewControllerAnimated:YES];
}

// 文本框内容发送改变的时候调用
- (void)textChange {
    
    self.addButton.enabled = self.name.text.length > 0 && self.number.text.length > 0;
}


@end
