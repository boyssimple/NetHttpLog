//
//  VCNetHTTPList.m
//  Test
//
//  Created by luowei on 2018/9/4.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import "VCNetHTTPList.h"
#import "LogUtils.h"

@interface CellNetHttpList : UITableViewCell
@property (nonatomic, strong) UILabel *lbUrl;
@property (nonatomic, strong) UILabel *lbParam;
@property (nonatomic, strong) UILabel *lbStartDate;
@property (nonatomic, strong) UILabel *lbEndDate;
@property (nonatomic, strong) UILabel *lbUseTime;
@property (nonatomic, strong) UILabel *lbResult;
@property (nonatomic, strong) UIView *vLine;
- (void)updateData:(NSDictionary*)data;
+ (CGFloat)calHeight:(NSDictionary*)data;
+ (CGFloat)calHeight;
@end


@interface VCNetHTTPList ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation VCNetHTTPList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonEvent)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonEvent)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *datas = [user objectForKey:[LogUtils getVCName]];
    if(datas){
        NSArray *rArray = (NSMutableArray *)[[datas reverseObjectEnumerator] allObjects];
        [self.dataSource addObjectsFromArray:rArray];
        [self.table reloadData];
    }
}

- (void)leftButtonEvent{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)rightButtonEvent{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:[LogUtils getVCName]];
    [user synchronize];
    [self.dataSource removeAllObjects];
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    return [CellNetHttpList calHeight:data];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellNetHttpList *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[CellNetHttpList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateData:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor whiteColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

@end


@implementation CellNetHttpList

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lbUrl = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbUrl.textColor = [UIColor blackColor];
        _lbUrl.font = [UIFont systemFontOfSize:14];
        _lbUrl.numberOfLines = 0;
        [self.contentView addSubview:_lbUrl];
        
        _lbParam = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbParam.textColor = [UIColor blackColor];
        _lbParam.font = [UIFont systemFontOfSize:14];
        _lbParam.numberOfLines = 0;
        [self.contentView addSubview:_lbParam];
        
        _lbStartDate = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbStartDate.textColor = [UIColor blackColor];
        _lbStartDate.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_lbStartDate];
        
        _lbEndDate = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbEndDate.textColor = [UIColor blackColor];
        _lbEndDate.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_lbEndDate];
        
        _lbUseTime = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbUseTime.textColor = [UIColor blackColor];
        _lbUseTime.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_lbUseTime];
        
        _lbResult = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbResult.textColor = [UIColor blackColor];
        _lbResult.font = [UIFont systemFontOfSize:14];
        _lbResult.numberOfLines = 0;
        [self.contentView addSubview:_lbResult];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
        [self.contentView addSubview:_vLine];
    }
    return self;
}

- (void)updateData:(NSDictionary*)data{
    self.lbUrl.text = [NSString stringWithFormat:@"请求地址：%@",[data objectForKey:@"url"]];
    self.lbParam.text = [NSString stringWithFormat:@"请求参数：%@",[data objectForKey:@"param"]];
    self.lbStartDate.text = [NSString stringWithFormat:@"开始时间：%@",[data objectForKey:@"start"]];
    self.lbEndDate.text = [NSString stringWithFormat:@"完成时间：%@",[data objectForKey:@"end"]];
    self.lbUseTime.text = [NSString stringWithFormat:@"使用时间：%@",[data objectForKey:@"time"]];
    self.lbResult.text = [NSString stringWithFormat:@"返回结果：%@",[data objectForKey:@"result"]];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    CGSize size = [self.lbUrl sizeThatFits:CGSizeMake(screenSize.width - 20, MAXFLOAT)];
    CGRect r = self.lbUrl.frame;
    r.size.width = screenSize.width - 20;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = 15;
    self.lbUrl.frame = r;
    
    size = [self.lbParam sizeThatFits:CGSizeMake(screenSize.width - 20, MAXFLOAT)];
    r = self.lbParam.frame;
    r.size.width = screenSize.width - 20;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = self.lbUrl.frame.origin.y + self.lbUrl.frame.size.height + 10;
    self.lbParam.frame = r;
    
    size = [self.lbStartDate sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbStartDate.frame;
    r.size.width = screenSize.width - 20;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = self.lbParam.frame.origin.y + self.lbParam.frame.size.height + 10;
    self.lbStartDate.frame = r;
    
    size = [self.lbEndDate sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbEndDate.frame;
    r.size.width = screenSize.width - 20;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = self.lbStartDate.frame.origin.y + self.lbStartDate.frame.size.height + 10;
    self.lbEndDate.frame = r;
    
    size = [self.lbUseTime sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    r = self.lbUseTime.frame;
    r.size.width = screenSize.width - 20;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = self.lbEndDate.frame.origin.y + self.lbEndDate.frame.size.height + 10;
    self.lbUseTime.frame = r;
    
    size = [self.lbResult sizeThatFits:CGSizeMake(screenSize.width - 20, MAXFLOAT)];
    r = self.lbResult.frame;
    r.size.width = screenSize.width - 20;
    r.size.height = size.height;
    r.origin.x = 10;
    r.origin.y = self.lbUseTime.frame.origin.y + self.lbUseTime.frame.size.height + 10;
    self.lbResult.frame = r;
    
    r = self.vLine.frame;
    r.size.width = screenSize.width;
    r.size.height = 1;
    r.origin.x = 0;
    r.origin.y = self.frame.size.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 350;
}

+ (CGFloat)calHeight:(NSDictionary*)data{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat height = 30;
    UILabel*lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont systemFontOfSize:14];
    lb.numberOfLines = 0;
    lb.text = [NSString stringWithFormat:@"请求地址：%@",[data objectForKey:@"url"]];
    height += [lb sizeThatFits:CGSizeMake(screenSize.width-20, MAXFLOAT)].height;
    
    lb.text = [NSString stringWithFormat:@"请求参数：%@",[data objectForKey:@"param"]];
    height += 10 + [lb sizeThatFits:CGSizeMake(screenSize.width-20, MAXFLOAT)].height;
    
    lb.numberOfLines = 1;
    lb.text = [NSString stringWithFormat:@"开始时间：%@",[data objectForKey:@"start"]];
    height += 10 + [lb sizeThatFits:CGSizeMake(screenSize.width-20, MAXFLOAT)].height;
    
    lb.text = [NSString stringWithFormat:@"完成时间：%@",[data objectForKey:@"end"]];
    height += 10 + [lb sizeThatFits:CGSizeMake(screenSize.width-20, MAXFLOAT)].height;
    
    lb.text = [NSString stringWithFormat:@"使用时间：%@",[data objectForKey:@"time"]];
    height += 10 + [lb sizeThatFits:CGSizeMake(screenSize.width-20, MAXFLOAT)].height;
    
    
    lb.numberOfLines = 0;
    lb.text = [NSString stringWithFormat:@"返回结果：%@",[data objectForKey:@"result"]];
    height += 10 + [lb sizeThatFits:CGSizeMake(screenSize.width-20, MAXFLOAT)].height;
    
    return height;
}
@end

