//
//  ViewController.m
//  KFCollectionViewAutoSizeLayout-demo
//
//  Created by K6F on 15/4/1.
//  Copyright (c) 2015年 K6F. All rights reserved.
//

#import "ViewController.h"
#import "KFCollectionViewAutoSizeSquareLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
@implementation ViewController{
    KFCollectionViewAutoSizeSquareLayout * layout;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    layout = [[KFCollectionViewAutoSizeSquareLayout alloc]init];
    layout.columnCount = [self p_getRandomNumberFrom:2 to:4];
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}
- (IBAction)refreshCells:(id)sender {
    layout.columnCount = [self p_getRandomNumberFrom:2 to:4];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self p_getRandomNumberFrom:20 to:40];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    float cRed = [self p_getRandomNumberFrom:1 to:255];
    float cGreen = [self p_getRandomNumberFrom:1 to:255];
    float cBlue = [self p_getRandomNumberFrom:1 to:255];
    UIColor * color = [UIColor colorWithRed:cRed/255 green:cGreen/255 blue:cBlue/255 alpha:1];
    [cell.subviews[0] setBackgroundColor :color ];
    return cell;
}

-(int)p_getRandomNumberFrom:(int)from to:(int)to

{
    
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
    
}
@end
