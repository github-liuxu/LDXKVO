//
//  NSObject+KVO.m
//  KVO
//
//  Created by 刘东旭 on 16/1/11.
//  Copyright © 2016年 百度. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import "KVOInfo.h"

@implementation NSObject (KVO)

+ (void)load {
    Method swissling_Method = class_getInstanceMethod([self class], @selector(swizzling_Dealloc));
    Method dealloc_Method = class_getInstanceMethod([self class], sel_registerName("dealloc"));
    method_exchangeImplementations(swissling_Method, dealloc_Method);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    KVOInfo *info = (__bridge KVOInfo *)(context);
    id changedValue = [change valueForKey:NSKeyValueChangeNewKey];
    info.changeBlock([changedValue isKindOfClass:[NSNull class]] ? nil : changedValue);
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath changeValue:(void(^)(id obj))change {
    KVOInfo *kvoInfo = [[KVOInfo alloc] init];
    kvoInfo.observed = self;
    kvoInfo.observing = observer;
    kvoInfo.keyPath = keyPath;
    kvoInfo.changeBlock = change;
    
    NSMutableArray* KVOArray = objc_getAssociatedObject(kvoInfo.observing, @"KVO_Array");
    if (!KVOArray) {
        KVOArray = [NSMutableArray array];
        objc_setAssociatedObject(kvoInfo.observing, @"KVO_Array", KVOArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [KVOArray addObject:kvoInfo];
    
    [kvoInfo.observed addObserver:kvoInfo.observing forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(kvoInfo)];
}

- (void)swizzling_Dealloc{
    NSMutableArray* KVOArray = objc_getAssociatedObject(self, @"KVO_Array");
    if (KVOArray==nil) {
        [self swizzling_Dealloc];
        return;
    }
    
    for (int i = 0; i < KVOArray.count; i++) {
        KVOInfo *info = KVOArray[i];
        [info.observed removeObserver:info.observing forKeyPath:info.keyPath];
        NSLog(@"移除");
    }
    [KVOArray removeAllObjects];
    KVOArray = nil;
    [self swizzling_Dealloc];
}

@end
