//
//  sysSreachBarViewController.m
//  twoKindsOfSearchBar
//
//  Created by ozx on 15/5/29.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "sysSreachBarViewController.h"
#import "publicDefine.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
@interface sysSreachBarViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray * arr2;
    UISearchBar *SearchBar ;
    UISearchDisplayController * resultController;
    NSMutableArray *searchResults;
}
@end

@implementation sysSreachBarViewController

-(NSMutableArray *)arr2{
    if (arr2==nil) {
        arr2 = [[NSMutableArray alloc] init];
    }
    return arr2;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        self.view.backgroundColor = [UIColor whiteColor];
        
        //导行栏文字
        UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        [customLab setTextColor:[UIColor blueColor]];
        [customLab setText:@"搜索"];
        customLab.font = [UIFont boldSystemFontOfSize:20];
        customLab.backgroundColor = [UIColor clearColor];
        self.navigationItem.titleView = customLab;
        
        //导行栏左边按钮
        UIButton *y = [UIButton buttonWithType:UIButtonTypeCustom];
        y.tag = 9;
        [y addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [y setImage:[UIImage imageNamed:@"DGback.png"] forState:UIControlStateNormal];
        y.frame = CGRectMake(0, 0, 20, 20);
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:y];
        leftButton.width = 20;
        self.navigationItem.leftBarButtonItem = leftButton;
    
    }


    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    
//    self.view.backgroundColor = [UIColor orangeColor];
    
    searchResults = [[NSMutableArray alloc ]init];
    
    
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
    
    [self setupSearchView];
}

#pragma mark -- 初始化搜索框
- (void)initSearchTextField
{
    SearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
    SearchBar.delegate = self;
    SearchBar.exclusiveTouch = YES;
    [SearchBar setPlaceholder:@"输入城市名"];
    
    resultController = [[UISearchDisplayController alloc] initWithSearchBar:SearchBar contentsController:self];
    resultController.searchResultsDataSource = self;
    resultController.searchResultsDelegate = self;
    
}

-(void)setupSearchView{
    [self initSearchTextField];
    self.tableView.tableHeaderView = SearchBar;//把搜索框放在tableview的第一行
}



-(void)back{
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        cell.textLabel.text = searchResults[indexPath.row][@"city"];
        
    }else{
        NSDictionary *dic = arr2[indexPath.row];
        cell.textLabel.text =dic[@"city"];
    }
    
    
    
    return cell;
}
#pragma  mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        return searchResults.count;
    }
    return arr2.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    return @"城市列表";

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //将经纬度传给上一个控制器
    NSDictionary * dicc =  arr2[indexPath.row];
//
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"Title" message:[NSString stringWithFormat:@"%@的纬度:%@,经度:%@",dicc[@"city"],dicc[@"lat"],dicc[@"lon"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}



#pragma mark UISearchDisplayDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    CGRect frame = resultController.searchResultsTableView.frame;
    if (frame.origin.y == 0 ) {
        frame.origin.y +=44;
        frame.size.height -=44;
        
        resultController.searchResultsTableView.frame = frame;
    }
    //    [self.view bringSubviewToFront:viewNavigation];
    
    searchResults = [[NSMutableArray alloc] init];//搜索结果数组
    if (SearchBar.text.length > 0 && ![ChineseInclude isIncludeChineseInString:SearchBar.text]){//搜索栏的文字是否包含中文
        
        
            
            NSArray *cityArray = arr2;
            
            for (int i=0; i < cityArray.count; i++){
                
                NSString *cityName = cityArray[i][@"city"];
                //判断是否包含中文
                if ([ChineseInclude isIncludeChineseInString:cityName]){//字典里面的城市名是否包含中文
                    
                    //把中文转换为拼音  进行搜索
                    NSString *cityPinYinStr = [PinYinForObjc chineseConvertToPinYin:cityName];
                    // NSLiteralSearch 区分大小写(完全比较)
                    // NSCaseInsensitiveSearch 不区分大小写
                    // NSNumericSearch 只比较字符串的个数，而不比较字符串的字面值
                    NSRange cityResult = [cityPinYinStr rangeOfString:SearchBar.text options:NSCaseInsensitiveSearch];//要将中文转化为拼音才能搜索?
                    //返回的NSRange(范围)1应该代表有一个相同,相同的概念(bei,就有一个bei在cityPinYinStr中)
                    if (cityResult.length > 0) {
                        [searchResults addObject:cityArray[i]];
                    }
                    
                    
                }else{//字典里面的城市名不包含中文
                    NSRange titleResult=[cityName rangeOfString:SearchBar.text options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        [searchResults addObject:cityArray[i]];
                    }
                }
            }
        
        // 中文搜索
    }else if (SearchBar.text.length > 0 && [ChineseInclude isIncludeChineseInString:SearchBar.text]){
        
        NSMutableSet *citySet = [NSMutableSet set];
        
    
            
            for (NSDictionary *dic in arr2) {
                NSRange titleResult = [dic[@"city"] rangeOfString:SearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleResult.length>0) {
                    [citySet addObject:dic];
                }
            }
        
        if (citySet.count>0) {
            
            [searchResults addObjectsFromArray:[citySet allObjects]];
            
        }
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //搜索栏一开始时所显示的文字
    searchBar.text = @"";
    return YES;
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{   //搜索栏取消按钮的点击事件,不实现该方法还是可以退出搜索控制器.
    searchBar.text = @"";
    [resultController setActive:NO animated:NO];
    
}



@end
