//
//  NSString+CYExtension.m
//  LightBox
//
//  Created by RRTY on 17/3/30.
//  Copyright © 2017年 deepAI. All rights reserved.
//

#import "NSString+CYExtension.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (CYExtension)


#pragma mark - 文件相关

//生成caches目录下不带后缀名的一个以时间戳为名的新文件路径
+ (NSString *)newTimeStrFilePath {
    
    //生成时间戳
    long recordTime = (NSInteger)[[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%ld",recordTime];
    
    //生成路径
    NSArray *CachesPaths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *filePath =[[CachesPaths objectAtIndex:0] stringByAppendingPathComponent:timeString];
    return filePath;
}
+ (NSString *)newMP4FilePath{
    return [NSString stringWithFormat:@"%@.mp4",[self newTimeStrFilePath]];
}

//获取路径的文件名（不包含拓展名）
-(NSString*)pathLastName{
    if( self && self.length ){
        NSString *lastPath = [self lastPathComponent];
        NSString *ext = [self pathExtension];
        NSInteger index = lastPath.length-ext.length-1;
        if( index < 0 )
            index = 0;
        NSString *name = [lastPath substringToIndex:index];
        
        return name;
    }
    return nil;
}

- (double)fileSize {
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];        //判断是否为路径
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        CGFloat totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] doubleValue];
    }
}

#pragma mark - 时间相关

/** 根据xxxx-xx-xx格式的当前时间返回yyyyMMddHHmmss格式的字符串时间戳 */
+ (NSString *)getCuttentDate {
    //转换时间格式为yyyy-MM-dd HH:mm:ss
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];//格式化
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* timerString = [dateFormatter stringFromDate:now];
    //转换时间格式为yyyyMMddHHmmss
    NSDate* date = [dateFormatter dateFromString:timerString];
    NSDateFormatter*df2 = [[NSDateFormatter alloc]init];//格式化
    [df2 setDateFormat:@"yyyyMMddHHmmss"];
    [df2 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    return [df2 stringFromDate:date];
}

#pragma mark - 文字排版

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, maxH);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma - mark - 正则过滤

-(BOOL)isUserName{
    //用户名格式
    NSString *regex = @"（\\w|.){0,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:self];
    if (isValid) {
        NSString *regex1 = @"\\d+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
        BOOL isValid1 = [predicate evaluateWithObject:self];
        if (!isValid1) {
            if (![self containsString:@"@"]) {
                NSString *regex4 = @"[.|_]+";
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex4];
                BOOL isValid4 = [predicate evaluateWithObject:self];
                if (!isValid4) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (BOOL)isSecret{
    //密码格式
    NSString *sec = @"^[0-9a-zA-Z]{6,12}$" ;
    NSPredicate *regSec = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",sec];
    if ([regSec evaluateWithObject:self] == YES) {
        return YES;
    }
    return  NO;
}

- (BOOL)isEmail{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:self] ;
}

- (BOOL)isMobileNumber
{
    //    所有1开头的11位数字
    NSString *general = @"^1\\d{10}$";
    
     NSPredicate *generalPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", general];
    if (self.length == 11 && [generalPredicate evaluateWithObject:self] == YES) {
        return YES;
    } else {
        return NO;
    }
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    /*
    //  中国移动：China Mobile
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //  中国联通：China Unicom
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //  中国电信：China Telecom
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        if (self.length == 11) {
            if ([[self substringToIndex:3] isEqualToString:@"177"]) {
                return YES;
            }
            if ([[self substringToIndex:3] isEqualToString:@"184"]) {
                return YES;
            }
            
        }
        return NO;
    }
     */
}

#pragma mark - 加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
@end
