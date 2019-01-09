//
//  RXAddressBook.h
//  RXGetAddressBook
//
//  Created by srxboys on 2018/12/13.
//  Copyright © 2018 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RXAddressBookDelegate.h"

NS_ASSUME_NONNULL_BEGIN

API_UNAVAILABLE(tvos) API_UNAVAILABLE(macos)
@interface RXAddressBook : NSObject
@property (nonatomic, weak) id<RXAddressBookDelegate> delegate;
- (void)getAddressBookInController:(UIViewController *)controller;

+ (BOOL)checkPhoneString:(NSString *)phoneString;

+ (NSString *)formatPhoneString:(NSString *)phontString;
@end

NS_ASSUME_NONNULL_END

