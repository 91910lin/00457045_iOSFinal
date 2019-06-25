#import <AudioToolbox/AudioToolbox.h>
#import "GreedySnakeView.h"
#import "CustomPoint.h"


@interface GreedySnakeView()
{
    SystemSoundID gu;
    SystemSoundID crash;
    UIView *maskView;
}
@property (nonatomic,retain) NSMutableArray *snakeData;
@property (nonatomic,retain) CustomPoint *foodsPoint;
//背景颜色
@property (nonatomic,retain) UIColor *bgColor;
@end
@implementation GreedySnakeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //設定背景顏色
        self.bgColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
        // 2個音效ＵＲＬ
        NSURL* guUrl = [[NSBundle mainBundle]
                        URLForResource:@"gu" withExtension:@"mp3"];
        NSURL* crashUrl = [[NSBundle mainBundle]
                           URLForResource:@"crash" withExtension:@"wav"];
        // 載入音效
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)guUrl , &gu);
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)crashUrl , &crash);
        //開始遊戲
        [self startGame];
    }
    return self;
}

- (void)startGame {
    self.snakeData = [[NSMutableArray alloc] init];
    for (int i = 1; i<6; i++) {
        CustomPoint *point = [[CustomPoint alloc]initWithX:i y:0];
        [self.snakeData addObject:point];
    }
    self.orient = kRight;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(move) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)move {
    CustomPoint *first  = self.snakeData[_snakeData.count - 1];
    CustomPoint *head = [[CustomPoint alloc] initWithX:first.x y:first.y];
    
    switch (self.orient) {
        case kDown:
            head.y += 1;
            break;
            
        case kLeft:
            head.x -= 1;
            break;
            
        case kRight:
            head.x += 1;
            break;
            
        case kUp:
            head.y -= 1;
            break;
            
        default:
            break;
    }


    if (head.x < 0 || head.x > WIDTH - 1 || head.y < 0 || head.y > HEIGHT - 1 || [_snakeData containsObject:head]) {
        // 播放碰撞的音效
        AudioServicesPlaySystemSound(crash);
        [self addView];
        [self.timer invalidate];
    }
    if ([head isEqual:_foodsPoint]) {
        // 播放吃食物的音效
        AudioServicesPlaySystemSound(gu);
        [_snakeData addObject:_foodsPoint];
        _foodsPoint = nil;
    } else {
        for (int i = 0; i < _snakeData.count - 1; i++) {
            CustomPoint *curP = _snakeData[i];
            CustomPoint *nexP = _snakeData[i+1];
            curP.x = nexP.x;
            curP.y = nexP.y;
        }
        [_snakeData setObject:head atIndexedSubscript:(_snakeData.count - 1)];
    }
    
    //安放食物的位置
    if (_foodsPoint == nil) {
        while (true) {
            //取隨機位置
            CustomPoint *newFoodsPoint = [[CustomPoint alloc] initWithX:(arc4random() % WIDTH) y:(arc4random() % HEIGHT)];
            //只有食物點與蛇的身體點不同的时候 才算成功
            if (![_snakeData containsObject:newFoodsPoint]) {
                _foodsPoint = newFoodsPoint;
                break;
            }
        }
    }
    
    [self setNeedsDisplay];
}

- (void)drawHeadInRect:(CGRect)rect context:(CGContextRef)ctx {
    CGContextBeginPath(ctx);
    CGFloat startAngle;
    switch (_orient) {
        case kUp:
            startAngle = M_PI * 7 / 4;
            break;
        case kDown:
            startAngle = M_PI * 3 / 4;
            break;
        case kLeft:
            startAngle = M_PI * 5 / 4;
            break;
        case kRight:
            startAngle = M_PI * 1 / 4;
            break;
        default:
            break;
    }
    CGContextAddArc(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect), POINT_SIZE / 2, startAngle, M_PI * 1.5 + startAngle , 0 );
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

- (void)drawRect:(CGRect)rect {
    //獲取繪圖API
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, CGRectMake(0, 0,WIDTH * POINT_SIZE , HEIGHT * POINT_SIZE));
    CGContextSetFillColorWithColor(ctx, [_bgColor CGColor]);
    //繪製背景
    CGContextFillRect(ctx, CGRectMake(0, 0, WIDTH * POINT_SIZE, HEIGHT * POINT_SIZE));
    //設定繪製蛇的填充顏色
    CGContextSetRGBFillColor(ctx, 153/255., 153/255., 153/255., 1);
    
    for (int i = 0; i < _snakeData.count; i++) {
        CustomPoint *cp = _snakeData[i];
        
        CGRect rect = CGRectMake(cp.x * POINT_SIZE, cp.y * POINT_SIZE, POINT_SIZE, POINT_SIZE);
        
       
        if (i < 4) {
            CGFloat inset = 4-i;
            CGContextFillEllipseInRect(ctx, CGRectInset(rect, inset, inset));
        }
        //如果是最後一個元素，代表蛇頭，繪製蛇頭
        else if ( i == _snakeData.count - 1) {
            [self drawHeadInRect:rect context:ctx];
        } else {
            CGContextFillEllipseInRect(ctx, rect);
        }
    }
    //繪製食物
    CGContextFillEllipseInRect(ctx, CGRectMake(_foodsPoint.x * POINT_SIZE, _foodsPoint.y * POINT_SIZE, POINT_SIZE, POINT_SIZE));
//    [_foodImage drawInRect:CGRectMake(_foodsPoint.x * POINT_SIZE, _foodsPoint.y * POINT_SIZE, POINT_SIZE, POINT_SIZE)];
}

- (void) addView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEBUTTON" object:nil];
    maskView = [[UIView alloc] initWithFrame:self.bounds];
    maskView.backgroundColor = self.bgColor;
    [self addSubview:maskView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
    label.text = [NSString stringWithFormat:@"本局您得了%lu分",(_snakeData.count - 5)];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1];
    label.center = CGPointMake(maskView.center.x, maskView.center.y - 60);
    label.font = [UIFont systemFontOfSize:30];
    [maskView addSubview:label];
    
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn2.frame = CGRectMake(0, 0, 200, 50);
    btn2.center = CGPointMake(maskView.center.x, maskView.center.y+35);
    btn2.backgroundColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1];
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds =  YES;
    [btn2 addTarget:self action:@selector(startGameAgain) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setTitle:@"再來一局" forState:(UIControlStateNormal)];
    [maskView addSubview:btn2];
}

- (void) startGameAgain {
    [maskView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWBUTTON" object:nil];
    [self startGame];
    /*[self.navigationController popToViewController:[array objectAtIndex:堆疊編號] animated:YES];*/
}
@end

