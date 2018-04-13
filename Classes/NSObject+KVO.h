//
//  NSObject+KVO.h
//  KVO
//
//  Created by 刘东旭 on 16/1/11.
//  Copyright © 2016年 百度. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath changeValue:(void(^)(id obj))change;

@end