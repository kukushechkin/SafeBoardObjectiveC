//
//  SBTheObject.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/22/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "SBTheObject.h"

@interface SBTheObject()
    @property (assign) BOOL isWorkInProgress;
@end

@implementation SBTheObject
@synthesize statusColor = m_statusColor;

- (instancetype)init {
    if(self = [super init]) {
        self.theName = @"new object";
        m_statusColor = [NSColor blueColor];
    }
    return self;
}

- (void)doWork {
    self.isWorkInProgress = YES;

    [self willChangeValueForKey:@"statusColor"];
    m_statusColor = [NSColor redColor];
    [self didChangeValueForKey:@"statusColor"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        while(self.theValue-- > 0) {
            NSLog(@"%ld", self.theValue);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Work is done");
            self.isWorkInProgress = NO;
            
            [self willChangeValueForKey:@"statusColor"];
            m_statusColor = [NSColor greenColor];
            [self didChangeValueForKey:@"statusColor"];
        });
    });
}

@end
