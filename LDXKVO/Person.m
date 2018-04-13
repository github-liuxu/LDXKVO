//
//  Person.m
//  KVO
//
//  Created by 刘东旭 on 16/1/7.
//  Copyright © 2016年 百度. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"%@",change);
}
- (void)abcd {
    NSLog(@"abcd");
}
@end
