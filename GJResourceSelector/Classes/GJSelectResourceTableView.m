//
//  GJSelectResourceTableView.m
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJSelectResourceTableView.h"
#import "GJSelectResourceTableViewCell.h"
@interface GJSelectResourceTableView ()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation GJSelectResourceTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[GJSelectResourceTableViewCell class] forCellReuseIdentifier:NSStringFromClass(GJSelectResourceTableViewCell.class)];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assetCollections.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GJSelectResourceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GJSelectResourceTableViewCell.class) forIndexPath:indexPath];
    if(self.assetCollections.count){
        cell.assetCollection = self.assetCollections[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78+14;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedBlock){
        self.selectedBlock(self.assetCollections[indexPath.row]);
    }
}

-(void)setAssetCollections:(NSArray<PHAssetCollection *> *)assetCollections{
    _assetCollections = assetCollections;
    [self reloadData];
}
@end
