//
//  EditViewController.m
//  05-通讯录
//
//  Created by swan on 2024/9/8.
//

#import "EditViewController.h"
#import "Contact.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameField.text = self.contact.name;
    self.numberField.text = self.contact.number;
    
    // 监听保存按钮的点击事件
    [self.saveButton addTarget:self action:@selector(saveClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)saveClicked{
    if ([self.delegate respondsToSelector:@selector(EditViewController:withContact:)]) {
//        Contact *con = [Contact new];
        self.contact.name = self.nameField.text;
        self.contact.number = self.numberField.text;
        [self.delegate EditViewController:self withContact:self.contact];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

/// 右上角编辑按钮
- (IBAction)editClick:(UIBarButtonItem *)sender {
    if (self.saveButton.hidden) { // 点击编辑
        sender.title = @"取消";
        self.nameField.enabled = YES;
        self.numberField.enabled = YES;
        self.saveButton.hidden = NO;
        // 让电话文本框成为第一响应者
        [self.numberField becomeFirstResponder];
    } else { // 点击取消
        sender.title = @"编辑";
        self.nameField.enabled = NO;
        self.numberField.enabled = NO;
        self.saveButton.hidden = YES;
        // 恢复到传过来的数据的值
        self.nameField.text = self.contact.name;
        self.numberField.text = self.contact.number;
    }
    
}

@end
