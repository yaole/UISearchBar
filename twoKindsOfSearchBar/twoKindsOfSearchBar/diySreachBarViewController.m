//
//  diySreachBarViewController.m
//  twoKindsOfSearchBar
//
//  Created by ozx on 15/5/29.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "diySreachBarViewController.h"
#import "publicDefine.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"

@interface diySreachBarViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    UITableView *resultTable;
    UIView *searchView;
    UITextField * searchTextFiled ;
    
    NSMutableArray *copyResultAry;
    NSMutableArray *arr2;
    NSMutableArray *newSearchArr;

}
@end

@implementation diySreachBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市选择";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"DGback.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem * backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    backBtn.width = 20;
    self.navigationItem.leftBarButtonItem = backBtn;
    
    copyResultAry = [[NSMutableArray alloc ]init];
    
    
    NSDictionary * dic1 = @{@"city":@"北京",@"lat":@"39.947136",@"lon":@"116.359332"};//116.359332,39.947136
    NSDictionary * dic2 =@{@"city":@"上海",@"lat":@"31.194623",@"lon":@"121.448524"};//121.448524,31.194623
    NSDictionary * dic3 =@{@"city":@"广州",@"lat":@"23.127194",@"lon":@"113.366679"};//113.366679,23.127194
    NSDictionary * dic4 =@{@"city":@"天津",@"lat":@"41.809528",@"lon":@"123.381065"};//
    NSDictionary * dic5 =@{@"city":@"陕西",@"lat":@"41.809528",@"lon":@"123.381065"};//
    
    NSDictionary * dic6 =@{@"city":@"深圳",@"lat":@"22.554647",@"lon":@"114.138106"};//114.138106,22.554647
    NSDictionary * dic7 =@{@"city":@"重庆",@"lat":@"29.530674",@"lon":@"106.575448"};//106.575448,29.530674
    NSDictionary * dic8 =@{@"city":@"武汉",@"lat":@"30.607454",@"lon":@"114.277478"};//114.277478,30.607454
    NSDictionary * dic9 =@{@"city":@"沈阳",@"lat":@"41.809528",@"lon":@"123.381065"};//123.381065,41.809528
    
    NSArray * arr1 =@[dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9];
    arr2 = [NSMutableArray arrayWithArray:arr1];

    [copyResultAry addObjectsFromArray:arr2];
        [self addSearchView ];
    [self searchResultTableView];
    
    [searchTextFiled addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

    
}

-(void)textFieldChanged:(id)text{
    //在这里进行搜索
    [arr2 removeAllObjects];
    UITextField * te = (UITextField *)text;
    NSString *cityname = [NSString string];
    newSearchArr = [[NSMutableArray alloc] init];
    NSString *SearchText = te.text;
    NSLog(@"%@",SearchText);
    if (SearchText.length == 0) {
        [arr2 addObjectsFromArray:copyResultAry];
        [resultTable reloadData];
        return;
    }
    if (SearchText.length > 0 && ![ChineseInclude isIncludeChineseInString:SearchText]){//搜索栏的文字是否包含中文
        if (copyResultAry!=nil)
        {
            for (NSDictionary *cityArray in copyResultAry){
                
                cityname = cityArray[@"city"];
                //判断是否包含中文
                if ([ChineseInclude isIncludeChineseInString:cityname]){//字典里面的城市名是否包含中文
                    
                    //把中文转换为拼音  进行搜索
                    NSString *cityPinYinStr = [PinYinForObjc chineseConvertToPinYin:cityname];
                    // NSLiteralSearch 区分大小写(完全比较)
                    // NSCaseInsensitiveSearch 不区分大小写
                    // NSNumericSearch 只比较字符串的个数，而不比较字符串的字面值
                    NSRange cityResult = [cityPinYinStr rangeOfString:SearchText options:NSCaseInsensitiveSearch];//要将中文转化为拼音才能搜索?
                    //返回的NSRange(范围)1应该代表有一个相同,相同的概念(bei,就有一个bei在cityPinYinStr中)
                    if (cityResult.length > 0) {
                        [newSearchArr addObject:cityArray];
                    }
                    
                    
                }else{//字典里面的城市名不包含中文
                    NSRange titleResult=[cityname rangeOfString:SearchText options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        [newSearchArr addObject:cityArray];
                    }
                }
                
            }
        }else{
            NSLog(@"为空");
        }
        
        // 中文搜索
    }else if (SearchText.length > 0 && [ChineseInclude isIncludeChineseInString:SearchText]){
        [newSearchArr removeAllObjects];
        for (NSDictionary *dict in copyResultAry){
                NSRange titleResult = [dict[@"city"] rangeOfString:SearchText options:NSCaseInsensitiveSearch];
                
                if (titleResult.length>0) {
                    [newSearchArr addObject:dict];
                }
        }
    }
    [arr2 removeAllObjects];
    [arr2 addObjectsFromArray:newSearchArr];
    [resultTable reloadData];
    
}


-(void)addSearchView
{
    
    searchView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,ScreenW, 44)];
    searchView.backgroundColor=[UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:.7];
    [self.view addSubview:searchView];
    
    searchTextFiled=[[UITextField alloc] initWithFrame:CGRectMake(15, 5, ScreenW-70, 34)];
    
    if ([searchTextFiled respondsToSelector:@selector(tintColor)]) {
        //        searchTextFiled.tintColor=SELECTED_COLOR;
        searchTextFiled.tintColor = [UIColor greenColor];
    }
    searchTextFiled.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 34)];//如放大镜
//    searchTextFiled.leftView.backgroundColor = [UIColor blackColor];
    searchTextFiled.leftViewMode=UITextFieldViewModeAlways;
//    UITextFieldViewModeNever,
//    UITextFieldViewModeWhileEditing,
//    UITextFieldViewModeUnlessEditing,
//    UITextFieldViewModeAlways
    searchTextFiled.delegate=self;
    searchTextFiled.placeholder = @"请输入搜索的城市名";
    searchTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
    [searchTextFiled setBackground:[UIImage imageNamed:@"SearchBg"]];
    searchTextFiled.returnKeyType=UIReturnKeySearch;
    [searchView addSubview:searchTextFiled];
    
    UIButton *searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitle:@"取消" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setFrame:CGRectMake(searchTextFiled.frame.size.width+searchTextFiled.frame.origin.x, 5, 50, 34)];
    searchButton.titleLabel.textAlignment=NSTextAlignmentCenter;
    searchButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [searchButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchButton];
    
}

-(void)searchResultTableView
{
    resultTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 40, ScreenW, ScreenH-108)];
    resultTable.delegate=self;
    resultTable.dataSource=self;
    resultTable.backgroundColor=[UIColor whiteColor];
    resultTable.tableFooterView=[[UIView alloc] init];
    if ([resultTable respondsToSelector:@selector(separatorInset)]) {
        resultTable.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    }
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(downKeyboard)];
    tap.delegate=self;
    [resultTable addGestureRecognizer:tap];
    [self.view addSubview:resultTable];
    
}

-(void)downKeyboard{
    [self.view endEditing:YES];
}

-(void)searchClick{

}

-(void)back:(UIButton * )btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    NSDictionary *dic = arr2[indexPath.row];
    cell.textLabel.text =dic[@"city"];
    
    
    
    
    return cell;
}
#pragma  mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr2.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"城市列表";
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    //将经纬度传给上一个控制器
    NSDictionary * dicc =  arr2[indexPath.row];
    //
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"Title" message:[NSString stringWithFormat:@"%@的纬度:%@,经度:%@",dicc[@"city"],dicc[@"lat"],dicc[@"lon"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}



@end
