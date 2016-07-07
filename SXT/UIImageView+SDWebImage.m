//
//  UIImageView+SDWebImage.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/8.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "UIImageView+SDWebImage.h"

@implementation UIImageView (SDWebImage)

- (void)downloadImage:(NSString *)url
                place:(UIImage *)place
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed | SDWebImageProgressiveDownload | SDWebImageContinueInBackground];
}



@end

