//
//  RXAddressBookDelegate.h
//  RXGetAddressBook
//
//  Created by srxboys on 2018/12/13.
//  Copyright © 2018 srxboys. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RXAddressBookDelegate <NSObject>

- (void)addressBookComplete:(NSString *)phoneString nameString:(NSString *)nameString;
- (void)addressBookComplete:(NSDictionary *)allDataSource;

@end

#define RXSTRENABLE(str) str && [str isKindOfClass:[NSString class]] && [str length] ? YES:NO


#define RXNULLSTR(str) str?str:@""
#define RXNULLDIC(dic) dic?dic:@{}
#define RXNULLARR(arr) arr?arr:@[]
#define RXNULLOBJ(obj) obj?obj:[NSObject new]


#pragma mark - allDataSource allKeys -
FOUNDATION_EXPORT NSString * const RX_AD_K_FULLNAME; ///< 全名            (Type = NSString)
FOUNDATION_EXPORT NSString * const RX_AD_K_NAME;     ///< 名字            (Type = NSString)
FOUNDATION_EXPORT NSString * const RX_AD_K_SURNMAE;  ///< 姓氏            (Type = NSString)
FOUNDATION_EXPORT NSString * const RX_AD_K_COMPANY;  ///< 公司            (Type = NSString)
FOUNDATION_EXPORT NSString * const RX_AD_K_PHONE;    ///< 手机号          (Type = NSString)
FOUNDATION_EXPORT NSString * const RX_AD_K_ADDRESS;  ///< 地址            (Type = NSString)
FOUNDATION_EXPORT NSString * const RX_AD_K_URL;      ///< urlAddresses   (Type = NSString)
FOUNDATION_EXPORT NSString * const RX_AD_K_EIMAIL;   ///< emailAddresses (Type = NSString)
FOUNDATION_EXPORT NSString * const RX_AD_K_IMAGE;    ///< imageData      (Type = NSData)
FOUNDATION_EXPORT NSString * const RX_AD_K_NOTE;     ///< 备注            (Type = NSString)




