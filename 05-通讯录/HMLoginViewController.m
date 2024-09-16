//
//  HMLoginViewController.m
//  05-通讯录
//
//  Created by swan on 2024/9/8.
//

#import "HMLoginViewController.h"
#import "MBProgressHUD/MBProgressHUD+JJ.h"
#import "ContactViewController.h"

@interface HMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *texAccount;
@property (weak, nonatomic) IBOutlet UITextField *txtPsw;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UISwitch *remPassword;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;

@end

@implementation HMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.texAccount addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.txtPsw addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];

    
    // 恢复开关状态
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.remPassword.on = [ud boolForKey:@"remPasswordKey"];
    self.autoLogin.on = [ud boolForKey:@"autoLoginKey"];
    // 恢复用户名密码
    self.texAccount.text = [ud objectForKey:@"userNameKey"];
    if (self.remPassword.isOn) {
        self.txtPsw.text = [ud objectForKey:@"passWordKey"];
    }
    
    if (self.autoLogin.isOn) {
        // 如果自动登录打开，那么直接登录
        [self btnLoginClicked:nil];
    }
    
    [self textChange];
    
}

// 记住密码开关的切换
- (IBAction)remPasswordChange:(UISwitch *)sender {
    // 如果关闭记住密码，那么同时关闭自动登录
    if (!sender.isOn) {
        [self.autoLogin setOn:NO animated:YES];
    }
}

// 自动登录开关的切换
- (IBAction)autoLoginChange:(UISwitch *)sender {
    // 如果开启自动登录，那么同时开启记住密码
    if (sender.isOn) {
        [self.remPassword setOn:YES animated:YES];
    }
}

- (IBAction)btnLoginClicked:(UIButton *)sender {
    MBProgressHUD *hud = [MBProgressHUD showActivityMessage:@"登录中..."];
     
    // 延迟 3s 在执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        if ([self.texAccount.text isEqualToString:@"1"] && [self.txtPsw.text isEqualToString:@"1"]) {
            // 就是跳
            [self performSegueWithIdentifier:@"login2contact" sender:sender];
            
            // 保存状态
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setBool:self.remPassword.isOn forKey:@"remPasswordKey"];
            [ud setBool:self.autoLogin.isOn forKey:@"autoLoginKey"];
            
            
            [ud setObject:self.texAccount.text forKey:@"userNameKey"];
            [ud setObject:self.txtPsw.text forKey:@"passWordKey"];
            [ud synchronize]; // 立即写入
            
            
        } else {
            // 提示错误信息
            [MBProgressHUD showError:@"用户名密码错误"];
        }
    });
}

// 只要走 sb 线，都会调用这个方法
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ContactViewController *contact = segue.destinationViewController;
    
    contact.userName = self.texAccount.text;
}

// 文本框内容发送改变的时候调用
- (void)textChange {
//    if (self.texAccount.text.length > 0 && self.txtPsw.text.length > 0) {
//        self.btnLogin.enabled = YES;
//    } else {
//        self.btnLogin.enabled = NO;
//    }
    
    self.btnLogin.enabled = self.texAccount.text.length > 0 && self.txtPsw.text.length > 0;
}



@end
