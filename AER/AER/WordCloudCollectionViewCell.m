//
//  WordCloudCollectionViewCell.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import "WordCloudCollectionViewCell.h"

@interface WordCloudCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *painLabel;

@end

@implementation WordCloudCollectionViewCell

- (void)configureWithString:(NSString *)string
{
    self.painLabel.text = string;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
