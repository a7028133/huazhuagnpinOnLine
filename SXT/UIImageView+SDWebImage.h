//
//  UIImageView+SDWebImage.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/8.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef void (^DownloadSuccessBlock) (SDImageCacheType cacheType, UIImage *image);
typedef void (^DownloadFailureBlock) (NSError *error);
typedef void (^DownloadProgressBlock) (CGFloat progress);

@interface UIImageView (SDWebImage)

/**
 *  SDWebImage 下载并缓存图片
 *
 *  @param url 图片的url
 *
 *  @param place 还未下载成功时的替换图片
 *
 */
- (void)downloadImage:(NSString *)url
                place:(UIImage *)place;



@end
