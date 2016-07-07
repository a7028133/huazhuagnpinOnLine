//
//  SXTFindGoodsImgListModel.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/7.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXTFindGoodsImgListModel : NSObject

/**图片地址*/
@property (copy, nonatomic) NSString *ImgView;

/**图片名称*/
@property (copy, nonatomic) NSString *ImgType;

/**图片尺寸*/
@property (copy, nonatomic) NSString *Resolution;

@end
