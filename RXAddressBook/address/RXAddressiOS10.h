//
//  RXAddressiOS10.h
//  RXGetAddressBook
//
//  Created by srx on 16/9/25.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXARE_Obj.h"

typedef void(^BlockAddress10)(BOOL status, NSString * phoneNum, NSString * nameString);

@interface RXAddressiOS10 : NSObject<RXARE_Obj>
@property (nonatomic, weak) id<RXAddressBookDelegate>delegate;
@property (nonatomic, copy) BlockAddress10 complete __deprecated_msg("废弃");
- (void)getAddress:(id)controller;
@end

/**
 * optional   <--> add framework
 */
