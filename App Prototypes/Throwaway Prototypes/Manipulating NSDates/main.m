//
//  main.m
//  tesingEnviornment
//
//  Created by Tait Madsen on 6/6/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *nowString = [formatter stringFromDate:[NSDate date]];
        NSLog(@"%@", nowString);
        
        [formatter setDateStyle:NSDateFormatterNoStyle];
        nowString = [formatter stringFromDate:[NSDate date]];
        NSLog(@"%@", nowString);
        
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        nowString = [formatter stringFromDate:[NSDate date]];
        NSLog(@"%@", nowString);
        
        NSDate *testDate = [formatter dateFromString:@"10/11/13 9:45 PM"];
        NSLog(@"%@", [formatter stringFromDate:testDate]);
        
    }
    
    return 0;
}






