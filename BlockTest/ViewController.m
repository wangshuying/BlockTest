//
//  ViewController.m
//  BlockTest
//
//  Created by wangshuying on 14/12/22.
//  Copyright (c) 2014年 wangshuying. All rights reserved.
//
//  reference: http://blog.parse.com/2013/02/05/objective-c-blocks-quiz/

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    exampleA();
    exampleB();
    exampleC();
    exampleD();
    exampleE();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


void exampleA() {
    char a = 'A';
    ^{
        printf("%c\n", a);
    }();
}

void exampleB_addBlockToArray(NSMutableArray *array) {
    char b = 'B';
    [array addObject:^{
        printf("%c\n", b);
    }];
    
    // without ARC, The code should be:
    /*
     [array addObject:[[^{
     printf("%C\n", b);
     } copy] autorelease]];
     */
}

void exampleB() {
    NSMutableArray *array = [NSMutableArray array];
    exampleB_addBlockToArray(array);
    void (^block)() = [array objectAtIndex:0];
    block();
}

void exampleC_addBlockArray(NSMutableArray *array) {
    [array addObject:^{
        printf("C\n");
    }];
}

void exampleC() {
    NSMutableArray *array = [NSMutableArray array];
    exampleC_addBlockArray(array);
    void (^block)() = [array objectAtIndex:0];
    block();
}

typedef void (^dBlock)();

dBlock exampleD_getBlock() {
    char d = 'D';
    return ^{
        printf("%c\n", d);
    };
}

void exampleD() {
    exampleD_getBlock()();
}

typedef void (^eBlock)();

eBlock exampleE_getBlock() {
    char e = 'E';
    void (^block)() = ^{
        printf("%c\n", e);
    };
    return block;
}

void exampleE() {
    eBlock block = exampleE_getBlock();
    block();
}

@end
