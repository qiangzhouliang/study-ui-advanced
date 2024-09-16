//
//  ViewController.m
//  01-点餐系统
//
//  Created by swan on 2024/9/5.
//

#import "ViewController.h"
#import "HMProvince.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

//*************************** 点餐系统*******************************
@property (nonatomic, strong) NSArray *foods;

// 水果
@property (weak, nonatomic) IBOutlet UILabel *fruitLbl;
// 主菜
@property (weak, nonatomic) IBOutlet UILabel *mainFoodLbl;
// 酒水
@property (weak, nonatomic) IBOutlet UILabel *drinkLbl;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)randomBtnClick:(UIButton *)sender;

//*************************** 省市选择 *******************************
@property (nonatomic, strong) NSArray *provinces;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewCity;
@property (weak, nonatomic) IBOutlet UILabel *lblProvince;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;

// 已选中的省
@property (nonatomic, strong) HMProvince *selProvince;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认选中
    for (int i = 0; i < self.foods.count; i++) {
        [self pickerView:self.pickerView didSelectRow:0 inComponent:i];
    }
    
}

#pragma mark - 懒加载
- (NSArray *)foods{
    if (_foods == nil) {
        _foods = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil]];
    }
    return _foods;
}

- (NSArray *)provinces{
    if (_provinces == nil) {
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
        NSMutableArray *arrModels = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArr) {
            HMProvince *province = [HMProvince proviceWithDict:dict];
            [arrModels addObject:province];
        }
        _provinces = arrModels;
    }
    return _provinces;
}

#pragma mark - 数据源方法
//-----------------点餐系统-----------------------------
//// 有多少组
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return self.foods.count;
//}
//
//// 每一组有多少行
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    return [self.foods[component] count];
//}

//----------------------省市选择-------------------
// 有多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// 每一组有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    // 如果是第0组 省 行数就是模型数组数量
    if (component == 0) {
        return self.provinces.count;
    } else {
        // 如果是第1组 市行数
        // 1.获取第0组省显示的是哪个省
        // 先获取第0组 选中的行号
        NSInteger selProIdx = [pickerView selectedRowInComponent:0];
        
        self.selProvince = self.provinces[selProIdx];
        
        // 2.根据省的城市数据去确定城市的行数
        return self.selProvince.cities.count;
    }
}

#pragma mark - 代理方法
//-----------------点餐系统-----------------------------
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSArray *comFoods = self.foods[component];
//    NSString *food = comFoods[row];
//    return food;
//}
//----------------------省市选择-------------------
// 单行每一行显示的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    
    // 如果是第0组 省 行数就是模型数组数量
    if (component == 0) {
        HMProvince *province = self.provinces[row];
        return province.name;
    } else {
        // 如果是第1组 市行数
        // 1.获取第0组省显示的是哪个省
        // 先获取第0组 选中的行号
//        NSInteger selProIdx = [pickerView selectedRowInComponent:0];
//        
//        HMProvince *province = self.provinces[selProIdx];
//        
        
        // 2.根据省的城市数据去确定城市的行数
        return self.selProvince.cities[row];
    }
}

// 选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    NSString *selFood = self.foods[component][row];
//    switch (component) {
//        case 0:
//            self.fruitLbl.text = selFood;
//            break;
//        case 1:
//            self.mainFoodLbl.text = selFood;
//            break;
//        case 2:
//            self.drinkLbl.text = selFood;
//            break;
//    }
    
    // -------------------省市选择---------------------
    if (component == 0) {
        [pickerView reloadComponent:1];
        
        // 1/ 去选中第1组城市 第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    // 1.获取省/市 索引
    NSInteger selProIdx = [pickerView selectedRowInComponent:0];
    NSInteger selCityIdx = [pickerView selectedRowInComponent:1];
    
    // 2.从集合中去取数据
    HMProvince *province = self.provinces[selProIdx];
    // 赋值
    self.lblProvince.text = province.name;
    self.lblCity.text = self.selProvince.cities[selCityIdx];
}
    
// 随机点餐按钮点击事件
- (IBAction)randomBtnClick:(UIButton *)sender {
    // 遍历集合中的所有组
    for (int i = 0; i < self.foods.count; i++) {
        // 生成随机数去选中
        NSUInteger random = arc4random_uniform((int)[self.foods[i] count]);
        // 获取第i组当前选中的行
        NSInteger selRowNum = [self.pickerView selectedRowInComponent:i];
        // 如果随机数和当前选中的行号一致，需要重新生成随机数
        while (random == selRowNum) {
            random = arc4random_uniform((int)[self.foods[i] count]);
        }
        
        // 让pickerView选中数据
        [self.pickerView selectRow:random inComponent:i animated:YES];
        
        // 将数据显示到 label 上
        [self pickerView:self.pickerView didSelectRow:random inComponent:i];
    }
    
}


@end
   
