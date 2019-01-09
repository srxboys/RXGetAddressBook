//
//  RXAdrObj.h
//  RXGetAddressBook
//
//  Created by srxboys on 2019/1/9.
//  Copyright © 2019 srxboys. All rights reserved.
//

#import "RXAddressBookDelegate.h"

@protocol RXAdrObj <NSObject>

@property (nonatomic, weak) id<RXAddressBookDelegate>delegate;
- (void)getAddress:(id)controller;
@end
