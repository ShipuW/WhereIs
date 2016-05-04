//
//  LoginPage.m
//  WhereIs
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "LoginPage.h"
#import "Login.h"
#import "UserInfo.h"
#import "FxAppSetting.h"

@implementation LoginPage

- (void)viewDidLoad {
    
    self.title = LoginTitle;
    [super viewDidLoad];
    //[self setNavigationLeft:@"NavigationBack.png" sel:nil];
}


- (BOOL)checkValid
{
    BOOL validate = YES;
    
    if (_userName.text.length <= 0 ||
        _password.text.length <= 0) {
        
        validate = NO;
        [self showIndicator:LoginCheckTip autoHide:YES afterDelay:YES];
    }
    
    return validate;
}

- (IBAction)tapLoginButton:(id)sender{
    if (![self checkValid]) {
        return;
    }
    
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@",
                      _userName.text,
                      _password.text
                      ];
    NSDictionary  *opInfo = @{@"url":LoginURL,
                              @"body":body};
    _operation = [[Login alloc] initWithDelegate:self opInfo:opInfo];
    
    [_operation executeOp];
    

}

- (void)opSuccess:(UserInfo *)data
{
    [super opSuccess:data];
    BASE_INFO_FUN(data.name);
    BASE_INFO_FUN(data.token);
    
    [FxAppSetting setValue:data.token forKey:@"token"];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
