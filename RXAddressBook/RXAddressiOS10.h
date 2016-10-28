//
//  RXAddressiOS10.h
//  RXGetAddressBook
//
//  Created by srx on 16/9/25.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockAddress10)(BOOL status, NSString * phoneNum, NSString * nameString);

@interface RXAddressiOS10 : NSObject

@property (nonatomic, copy) BlockAddress10 complete;
- (void)getAddress:(id)controller;

@end

/**
 * optional   <--> add framework
 */