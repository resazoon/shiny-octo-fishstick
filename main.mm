#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <mach-o/dyld.h>
#include <vector>

// 相棒の解析データ（住所）
#define ADDR_VIEW_MATRIX 0x03A3AC78  
#define OFF_PLAYER_STATE 0x50        
#define OFF_COORD_XYZ    0x1A0       

struct Matrix4x4 { float m[16]; };
struct Vector3 { float x, y, z; };
struct Vector2 { float x, y; };

bool WorldToScreen(Vector3 pos, Vector2 &screen, Matrix4x4 matrix) {
    float width = [UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale;
    float height = [UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale;
    float w = matrix.m[3] * pos.x + matrix.m[7] * pos.y + matrix.m[11] * pos.z + matrix.m[15];
    if (w < 0.01f) return false;
    float x = matrix.m[0] * pos.x + matrix.m[4] * pos.y + matrix.m[8] * pos.z + matrix.m[12];
    float y = matrix.m[1] * pos.x + matrix.m[5] * pos.y + matrix.m[9] * pos.z + matrix.m[13];
    screen.x = (width / 2) * (1 + x / w);
    screen.y = (height / 2) * (1 - y / w);
    return true;
}

@interface MyESPView : UIView
@end

@implementation MyESPView
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); // 動作確認用の赤い四角
    CGContextFillRect(context, CGRectMake(100, 100, 50, 50)); 
}
@end

__attribute__((constructor))
static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        MyESPView *esp = [[MyESPView alloc] initWithFrame:keyWindow.bounds];
        esp.backgroundColor = [UIColor clearColor];
        esp.userInteractionEnabled = NO;
        [keyWindow addSubview:esp];
    });
}
