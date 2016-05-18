# RXGetAddressBook
* 获取系统通讯录的名字和电话【srxboys】
* 亲测 实现  > iOS6

-
```objc
    /**
    *这里为什么注释掉
    *--如果iOS版本`<9`，就会崩溃 找不到 Contacts 系统库文件
    */

    //#if __IPHONE_9_0
    //    #import <Contacts/Contacts.h>
    //    #import <ContactsUI/ContactsUI.h>
    //#else
    #import <AddressBook/AddressBook.h>
    #import <AddressBookUI/AddressBookUI.h>
    //#endif
```
-
###提供判断是否为`11`为的手机号`正则表达式`判断
```objc
    ///是否为手机号码
    - (BOOL)checkPhoneNum:(NSString *)str {
        NSString *regex = @"1[0-9]{10}";

        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

        BOOL isMatch = [pred evaluateWithObject:str];
        return isMatch;
    }
```
-
###效果图(如下):
-
![RXGetAddressBook](https://github.com/srxboys/RXGetAddressBook/blob/master/srxboys_RXGetAddressBook.gif) 
-
###（Thanks）谢谢观看！！！！！