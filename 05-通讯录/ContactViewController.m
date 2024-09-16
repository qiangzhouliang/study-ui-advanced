//
//  ContactViewController.m
//  05-通讯录
//
//  Created by swan on 2024/9/8.
//

#import "ContactViewController.h"
#import "AddViewController.h"
#import "EditViewController.h"

#define KFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contacts.data"]

@interface ContactViewController () <UITableViewDataSource, AddViewControllerDelegate, EditViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactViewController

- (NSMutableArray *)contacts{
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加左上角注销按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationItem.title = self.userName;
    
    // 取消分割线
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // 解挡联系人信息
    // 获取 doc 路径
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfFile:KFilePath];
    self.contacts = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[[NSArray class], [Contact class]]] fromData:data error:&error];
    NSLog(@"%@", self.contacts);
}

/// 注销按钮的点击事件
- (void)logOut {
    
    // 弹出一个对话框
    UIAlertController *toast = [UIAlertController alertControllerWithTitle:@"您确定要注销吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [toast dismissViewControllerAnimated:true completion:nil];
        
    }];
    // 创建UIAlertAction，用于处理按钮点击事件
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [toast dismissViewControllerAnimated:true completion:nil];
        // 返回上一个控制器
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    // 将UIAlertAction添加到UIAlertController
    [toast addAction:cancleAction];
    [toast addAction:alertAction];
    // 获取当前视图控制器显示弹框
    [self presentViewController:toast animated:true completion:nil];
    
}

/// 只要走 sb 线 无论是自动型还是手动型都会调用
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *VC = segue.destinationViewController;
    if ([VC isKindOfClass:[AddViewController class]]) {
        ((AddViewController *)VC).delegate = self;
    } else {
        // 顺序传值
        EditViewController *edit = (EditViewController *)VC;
        // 获取点击 cell 的位置（indexPath）
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        edit.contact = self.contacts[indexPath.row];
        edit.delegate = self;
    }
}


#pragma mark - editViewController 代理
- (void)EditViewController:(EditViewController *)editViewController withContact:(Contact *)contact{
    
    
    [self.tableView reloadData];
    
    // 归档数组联系人
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self.contacts requiringSecureCoding:YES error:nil];
    BOOL isSuccess = [archiveData writeToFile:KFilePath atomically:YES];
    if(!isSuccess)
    {
        NSLog(@"归档存储失败:%d", isSuccess);
    }
}

#pragma mark - addViewController 代理
- (void)AddViewController:(AddViewController *)addViewController withContact:(Contact *)contact{
    NSLog(@"%@-------------%@", contact.name, contact.number);
    [self.contacts addObject:contact];
    
    // 刷新
    [self.tableView reloadData];
    
    // 获取 doc 路径
    NSError *error = nil;
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self.contacts requiringSecureCoding:YES error:&error];
    if (archiveData == nil || error) {
        NSLog(@"归档失败:%@", error);
    }
    BOOL isSuccess = [archiveData writeToFile:KFilePath atomically:YES];
    if(!isSuccess)
    {
        NSLog(@"归档存储失败:%d", isSuccess);
    }
    
}


// item 枚举的区别
-(void)test {
    // 添加左上角注销按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:nil]; // 细
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:nil]; // 粗
    
    self.navigationItem.leftBarButtonItems = @[item,item1];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contact_cell"];
    
    Contact *contact = self.contacts[indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.number;
    
    return cell;
}

// 让 Tableview 进入编辑模式 （左滑）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 把数组中的元素删掉
    [self.contacts removeObjectAtIndex:indexPath.row];
    // 删除一行
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    // 更新归档
    // 归档数组联系人
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self.contacts requiringSecureCoding:YES error:nil];
    [archiveData writeToFile:KFilePath atomically:YES];
}



@end
