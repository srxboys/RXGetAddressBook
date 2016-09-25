//
//  RXAddressiOS9.h
//  RXGetAddressBook
//
//  Created by srx on 16/9/25.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BlockAddress9)(BOOL status, NSString * phoneNum, NSString * nameString);

@interface RXAddressiOS9 : UIView
@property (nonatomic, copy) BlockAddress9 complete;
- (void)getAddress:(id)controller;
@end

/**
  * optional   <--> add framework
  */