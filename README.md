# RXGetAddressBook
* 获取系统通讯录的名字和电话【srxboys】
* 亲测 实现  > iOS6

-
## POD

```objc
     pod 'RXGetAddressBook'
     
     //info.plist 设置
     //xml:
     <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<string>需要通讯录权限</string>
</plist>
     //直观
Privacy - Contacts Usage Description  ->  string : 需要通讯录权限
```

-
## EXAMPLE
```objc
    //初始化对象 在viewDidLoad
   __weak typeof(self)weakSelf = self;
    
    //iOS >=iOS9
    _objct10 = [[RXAddressiOS10 alloc] init];
    _objct10.complete = ^(BOOL status, NSString * phoneNum, NSString * nameString) {
        if(status) {
            weakSelf.phoneLabel.text = phoneNum;
        }
        
        weakSelf.nameLabel.text = nameString;
    };
    
    //iOS < iOS9
    _objct9 = [[RXAddressiOS9 alloc] init];
    _objct9.complete = ^(BOOL status, NSString * phoneNum, NSString * nameString) {
        if(status) {
            weakSelf.phoneLabel.text = phoneNum;
        }
        weakSelf.nameLabel.text = nameString;
    };
    
    
    
    //调用通讯录 方法
    if(iOS9Later) {
        //iOS >=iOS9
        [_objct10 getAddress:self];
    }
    else {
        //iOS < iOS9
        [_objct9 getAddress:self];
    }

```
-
###提供判断是否为`11`位的手机号`正则表达式`判断
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
