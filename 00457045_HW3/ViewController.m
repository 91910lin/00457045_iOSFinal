#import "ViewController.h"
#import "GreedySnakeView.h"
#import "ReferenceViewController.h"

@interface ViewController (){
    UIButton *psBtn;
}
@property (nonatomic, retain) GreedySnakeView *snakeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideButton) name:@"HIDEBUTTON" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showButton) name:@"SHOWBUTTON" object:nil];

    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat gap = (screenWidth - WIDTH * POINT_SIZE)/2;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(gap, 30, screenWidth - 3*gap - 40, 40)];
    label.font = [UIFont systemFontOfSize:30 weight:UIFontWeightThin];
    label.textColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1];
    label.text = @"貪吃蛇";
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(referenceShow:)];
    [label addGestureRecognizer:tap];
    [self.view addSubview:label];
    
    
    
    
    
    psBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    psBtn.frame = CGRectMake(screenWidth - 35 - gap, 32.5, 35, 35);
    [psBtn setImage:[UIImage imageNamed:@"pause.png"] forState:(UIControlStateNormal)];
    [psBtn setImage:[UIImage imageNamed:@"start.png"] forState:(UIControlStateSelected)];
    [psBtn addTarget:self action:@selector(pauseAndStartAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:psBtn];
    
    _snakeView = [[GreedySnakeView alloc] initWithFrame:CGRectMake(gap, screenHeight - gap - HEIGHT * POINT_SIZE,WIDTH *POINT_SIZE , HEIGHT *POINT_SIZE)];
    
    _snakeView.layer.borderWidth = 3;
    _snakeView.layer.borderColor = [[UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1] CGColor];
    _snakeView.layer.cornerRadius = 6;
    _snakeView.layer.masksToBounds = YES;
    
    [self.view addSubview:_snakeView];
    self.view.multipleTouchEnabled = YES;
    
    for (int i = 0; i < 4; i ++) {
        //創建手勢處理器，指定使用該控制器的handleSwipe:方法處理輕掃手势
        UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        gesture.numberOfTouchesRequired = 1;
        gesture.direction = 1 << i;
        [self.view addGestureRecognizer:gesture];
    }
}

- (void) handleSwipe:(UISwipeGestureRecognizer *)gesture {
    NSUInteger direction = gesture.direction;
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            if(_snakeView.orient != kRight) // 只要不是向右，即可改变方向
                _snakeView.orient = kLeft;
            break;
        case UISwipeGestureRecognizerDirectionUp:
            if(_snakeView.orient != kDown) // 只要不是向下，即可改变方向
                _snakeView.orient = kUp;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            if(_snakeView.orient != kUp) // 只要不是向上，即可改变方向
                _snakeView.orient = kDown;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            if(_snakeView.orient != kLeft) // 只要不是向左，即可改变方向
                _snakeView.orient = kRight;
            break;
    }
}

- (void)pauseAndStartAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [_snakeView.timer setFireDate:[NSDate distantFuture]];
    } else {
        [_snakeView.timer setFireDate:[NSDate date]];
    }
}

- (void)hideButton {
    psBtn.hidden = YES;
}

- (void)showButton {
    psBtn.hidden = NO;
}

- (void)referenceShow:(UITapGestureRecognizer *)sender {
    [self presentViewController:[ReferenceViewController new] animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
