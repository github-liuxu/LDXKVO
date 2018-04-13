//
//  KOVHelper.h
//  KVO
//
//  Created by 刘东旭 on 16/3/25.
//  Copyright © 2016年 百度. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOInfo : NSObject

@property (nonatomic,weak)NSObject *observed;
@property (nonatomic,strong)NSObject *observing;
@property (copy)NSString *keyPath;
@property (copy)void(^changeBlock)(id obj);
@end
