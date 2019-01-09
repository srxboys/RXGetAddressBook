//
//  RXARE_Obj.h
//  RXGetAddressBook
//
//  Created by srxboys on 2019/1/9.
//  Copyright © 2019 srxboys. All rights reserved.
//

#import "RXAddressBookDelegate.h"


@protocol RXARE_Obj <NSObject>
@property (nonatomic, weak) id<RXAddressBookDelegate>delegate;
- (void)getAddress:(id)controller;
@end


