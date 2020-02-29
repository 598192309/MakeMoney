//
//  LqNoPasteTextField.m
//  LqTool
//
//  Created by lqq on 2019/12/21.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "LqNoPasteTextField.h"

@implementation LqNoPasteTextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    UIMenuController*menuController = [UIMenuController sharedMenuController];
    if(menuController) {
        [UIMenuController sharedMenuController].menuVisible=NO;
    }
    return NO;
}
@end
