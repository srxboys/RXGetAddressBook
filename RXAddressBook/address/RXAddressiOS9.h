//
//  RXAddressiOS9.h
//  RXGetAddressBook
//
//  Created by srx on 16/9/25.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXAdrObj.h"

typedef void(^BlockAddress9)(BOOL status, NSString * phoneNum, NSString * nameString);

@interface RXAddressiOS9 : NSObject<RXAdrObj>
@property (nonatomic, weak) id<RXAddressBookDelegate>delegate;
@property (nonatomic, copy) BlockAddress9 complete __deprecated_msg("废弃");
- (void)getAddress:(id)controller;
@end

/**
  * optional   <--> add framework
  */
