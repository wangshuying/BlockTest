//
//  ViewController.m
//  BlockTest
//
//  Created by wangshuying on 14/12/22.
//  Copyright (c) 2014年 wangshuying. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    exampleA();
    examleB();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


void exampleA() {
    char a = 'A';
    ^{
        printf("%C\n", a);
    }();
}

void exampleB_addBlockToArray(NSMutableArray *array) {
    char b = 'B';
    [array addObject:^{
        printf("%C\n", b);
    }];
    
    // without ARC, The code should be:
    /*
     [array addObject:[[^{
     printf("%C\n", b);
     } copy] autorelease]];
     */
}

void examleB() {
    NSMutableArray *array = [NSMutableArray array];
    exampleB_addBlockToArray(array);
    void (^block)() = [array objectAtIndex:0];
    block();
}

@end
