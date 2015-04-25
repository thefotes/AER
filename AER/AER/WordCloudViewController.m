//  WordCloudViewController.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "WordCloudViewController.h"
#import "WordCloudCollectionViewCell.h"

@interface WordCloudViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (copy, nonatomic) NSArray *painPoints;

@end

@implementation WordCloudViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WordCloudCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([WordCloudCollectionViewCell class])];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 80);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.allowsMultipleSelection = YES;
}

- (NSArray *)painPoints
{
    return _painPoints = _painPoints ?: @[@"Fitness", @"Health", @"Mental", @"Physical"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WordCloudCollectionViewCell *cell = (WordCloudCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WordCloudCollectionViewCell class]) forIndexPath:indexPath];
    
    [cell configureWithString:self.painPoints[(NSUInteger)indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WordCloudCollectionViewCell *cell = (WordCloudCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = !cell.selected;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.painPoints count];
}

@end
