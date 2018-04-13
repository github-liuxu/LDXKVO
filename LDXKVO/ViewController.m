//
//  ViewController.m
//  KVO
//
//  Created by 刘东旭 on 16/1/7.
//  Copyright © 2016年 百度. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "AA.h"
#import "NSObject+KVO.h"

@interface ViewController ()
@property (nonatomic,strong)Person *per;
@property (nonatomic,strong)AA *aa;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _per = [Person new];
    _aa = [[AA alloc] init];
    
    [_per addObserver:_aa forKeyPath:@"name" changeValue:^(id obj) {
        NSLog(@"%@",obj);
    }];
    
    self.name = @"1234";
    [_per setValue:@"weqweq" forKey:@"ppp"];
    _per.name = @"per";
    _aa.name = @"aa";
    
    

}

-(void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"控制器完了");
//    [_aa removeObserver:_per forKeyPath:@"name"];
}

@end
