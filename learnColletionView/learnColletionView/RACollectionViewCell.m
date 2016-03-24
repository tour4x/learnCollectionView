//
//  RACollectionViewCell.m
//  learnColletionView
//
//  Created by user on 16/3/24.
//  Copyright © 2016年 JiuFang. All rights reserved.
//

#import "RACollectionViewCell.h"

@implementation RACollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        _imageView.alpha = .7f;
    }else {
        _imageView.alpha = .1f;
    }
    
}

@end
