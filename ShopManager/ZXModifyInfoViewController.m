//
//  ZXModifyInfoViewController.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/28.
//  Copyright © 2016年 zx. All rights reserved.
//
#define TOSTRING(a)  [NSString stringWithFormat:@"%@",(a)]
#define TONUMBER(a,type)  [a type]

#import "ZXModifyInfoViewController.h"
#import "ZXNewShopViewController.h"

#import "ShopCellView.h" 

#import "ZXNetwork.h"

#import "ShopModel.h"
#import "ShopViewModel.h"
#import "SearchShopModel.h"

#import <Foundation/NSJSONSerialization.h>
#import "ZXShopFilterViewController.h"
#import "AppDelegate.h"
@interface ZXModifyInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ZXNetworkDelegate,ZXControllerClickOKDelegate>
@property(nonatomic) BOOL tabViewInitial;
@property(nonatomic,strong) NSMutableDictionary* shopViewInitDict;
@property(nonatomic,strong) NSMutableArray *viewModels; 
@property(nonatomic,assign) BOOL isLoadingData;
@property(nonatomic,assign) BOOL isFilterOpen;
@property(nonatomic,strong) SearchShopModel * searchModel;
@end

@implementation ZXModifyInfoViewController


#pragma mark 修改店铺之后点击确定
-(void) newShopControllerEndEditShopModel:(ShopModel *)model atIndex:(NSInteger)index
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@" eidt end %@",[model toPostData]);
    ZXNetwork * net=[[ZXNetwork alloc] init];
    net.delegate=self;
    [net requestPostFormUrlEncoded:[model toPostData] forUrlStr:apiUpdateUrl requestType:ZXUpdateShop object:[NSString stringWithFormat:@"%ld",index]];
}
-(void)networkUpdateResult:(NSData *  _Nullable) data Response:(NSURLResponse * _Nullable) response Error:( NSError * _Nullable) error  object:(id _Nullable ) param
{
    NSInteger index=[(NSString*)param integerValue];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:NSJSONReadingMutableContainers
                    error:&err];
    NSLog(@"response data %@",dic);
    if( [((NSString*)[dic objectForKey:@"success"]) isEqual:@"true"])
    {
        non_args_non_ret_block updateUI=^{
            UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"消息" message:@"店铺更新成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * act=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * aaa)
            {
                ShopViewModel* viewmodel=[self.viewModels objectAtIndex:index];
                viewmodel.shopView=viewmodel.shopView;
                NSIndexPath* indexpath=[NSIndexPath indexPathForRow:index inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationTop];
            }];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
//            [self presentViewController:alert animated:YES completion:^{
//                [alert dismissViewControllerAnimated:YES completion:nil];
//               
//            }];
        };
        dispatch_async(dispatch_get_main_queue(), updateUI);
    }else{
        non_args_non_ret_block updateUI=^{
            NSString* msg=[NSString  stringWithFormat:@"店铺更新失败%@", (NSString*)[dic objectForKey:@"error"]];
            UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"消息" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * act=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
        };
        dispatch_async(dispatch_get_main_queue(), updateUI);
    }
 
}
#pragma mark 控制器点击确定返回时候
-(void) controllerClick:(id _Nonnull )controller object:(_Nullable id) obj type:(ZXControllerType) intType
{
    switch (intType) {
        case ZXFilterController:
            {
                [self.navigationController popViewControllerAnimated:YES];
                self.searchModel.pagecount=0;
                self.isLoadingData=true;
                if(self.viewModels.count>0)
                    [self.viewModels removeObjectsInRange:NSMakeRange(0, self.viewModels.count)];
                [self.tableView reloadData];
                ZXNetwork * net=[[ZXNetwork alloc] init];
                net.delegate=self;
                NSLog(@"search model %@ ",[self.searchModel toPostData]);
                [net requestPostFormUrlEncoded:[self.searchModel toPostData] forUrlStr:apiUrl requestType:ZXGetShopInfo object:nil];
            }
            break;
        case  ZXUpdateController://通过 newShopControllerEndEditShopModel 实现
            break;
        default:
            break;
    }
}
#pragma mark 网络获取数据成功返回时候
-(void) networkGetResultData:(NSData *)data Response:(NSURLResponse *)response Error:(NSError *)error
{
    NSError *err;
    NSArray *dic = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:NSJSONReadingMutableContainers
                    error:&err];
    if(dic.count==0){
        self.isLoadingData=false;
        self.isFilterOpen=false;
        return;
    } 
    for (NSDictionary* key in  dic)
    {
        ShopModel * model=[[ShopModel alloc] init];
        for (NSString* k in [key keyEnumerator])
        {
            [model setValue:[key valueForKey:k] forKey:k];
        }
        ShopViewModel * viewmo=[[ShopViewModel alloc] init];
        viewmo.shopView=model;
        [self.viewModels addObject:viewmo];
    }
    [self.tableView reloadData];
    self.searchModel.pagecount++;
    self.searchModel.authType=self.authType;
    self.isLoadingData=false;
    self.isFilterOpen=false;
  }

#pragma mark 店铺列表滑动加载更多
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float allheight=scrollView.contentSize.height;
    float currentoffset=scrollView.contentOffset.y;
    float visualheight=scrollView.frame.size.height;
    ZXNetwork * net=[[ZXNetwork alloc] init];

    net.delegate=self;
    if(self.isLoadingData==false&&self.isFilterOpen==false){
        if(allheight*0.9<=(currentoffset+visualheight)){
            self.isLoadingData=true;
            NSString * postData=[self.searchModel toPostData];
            NSLog(@"post data %@",postData);
            [net requestPostFormUrlEncoded:postData forUrlStr:apiUrl requestType:ZXGetShopInfo object:nil];
        }
    }
}

#pragma mark 页面加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    [ShopModel objDicInit];
    [SearchShopModel objDicInit];
    
    UIBarButtonItem * button=[[UIBarButtonItem alloc] initWithTitle:@"过滤" style:UIBarButtonItemStylePlain target:self   action:@selector(btnSearchFilterClick)];
    self.navigationItem.rightBarButtonItems=@[button];
    
    self.tabViewInitial=false;
    self.shopViewInitDict=[NSMutableDictionary dictionary];
    self.tableView=[[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ShopCellView class] forCellReuseIdentifier:@"123123"];
    //self.tableView.backgroundColor=[UIColor colorWithRed:180 green:229 blue:236 alpha:1];
    self.view.backgroundColor=[UIColor yellowColor];
    self.viewModels=[NSMutableArray array];
    self.isLoadingData=true;
    self.isFilterOpen=false;
    self.searchModel=[[SearchShopModel alloc] init];
    self.searchModel.username=@"zx";
    self.searchModel.password=@"fuck";
    self.searchModel.pagecount=0;
   self.searchModel.username= [AppDelegate authInfoGetUsername];
    self.searchModel.password=[AppDelegate authInfoGetPassword];
    
    ZXNetwork * net=[[ZXNetwork alloc] init];
    net.delegate=self;
    [net requestPostFormUrlEncoded:[self.searchModel toPostData] forUrlStr:apiUrl requestType:ZXGetShopInfo object:nil];
    
    [self.tableView reloadData];
}
#pragma mark 点击过滤按钮时候
-(void) btnSearchFilterClick{
     self.isFilterOpen=true;
    ZXShopFilterViewController* filter=[[ZXShopFilterViewController alloc] init];
    filter.searchModel=self.searchModel;
    filter.delegate=self;
   
    [self.navigationController pushViewController:filter animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 选择单个店铺
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopViewModel * viewmo=(ShopViewModel *)[self.viewModels objectAtIndex:indexPath.row];
    NSString * tt=[NSString stringWithFormat:@"选择对\"%@\"的操作",viewmo.shopView.shopNumber];
    UIAlertController * alert= [UIAlertController alertControllerWithTitle:tt message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * updateproc=[UIAlertAction  actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *act){
      
        ZXNewShopViewController * cont=[[ZXNewShopViewController alloc] initWithNibName:@"NewShopView" bundle:nil];
        cont.shopModel=viewmo.shopView;
        cont.procType=ZXProcTypeModify;
        cont.modelIndex=indexPath.row;
        cont.delegate=self;
        [self.navigationController pushViewController:cont animated:YES];
    }];
//    UIAlertAction * newproc=[UIAlertAction  actionWithTitle:@"新建" style:UIAlertActionStyleDefault handler:^(UIAlertAction *act){
//        ZXNewShopViewController * cont=[[ZXNewShopViewController alloc] initWithNibName:@"NewShopView" bundle:nil];
//        cont.shopModel=viewmo.shopView;
//        cont.procType=ZXProcTypeCreateNew;
//         cont.modelIndex=indexPath.row;
//        [self.navigationController pushViewController:cont animated:YES];
//    }];
    UIAlertAction * cancleproc=[UIAlertAction  actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:updateproc];
//    [alert addAction:newproc];
    [alert addAction:cancleproc];
    [self presentViewController:alert animated:YES completion:nil];;
}
#pragma mark tableview 行高实现
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ShopViewModel * viewModel =[self.viewModels objectAtIndex:indexPath.row];
    return  [viewModel rowHeight];
}
#pragma mark tableview 分组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.viewModels.count;
}
#pragma mark tableview cellforrow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    ShopCellView* v= [tableView dequeueReusableCellWithIdentifier:@"123123" forIndexPath:indexPath];
    if(v==nil){
        self.tabViewInitial=true;
        v= [[ShopCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123123"];
       
    }
    v.viewModel=[self.viewModels objectAtIndex:indexPath.row];
    return v;
}

@end
