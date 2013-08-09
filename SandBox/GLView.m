//
//  GLView.m
//  SandBox
//
//  Created by akosuge on 2013/08/08.
//
//

#import "GLView.h"
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>

// VBOのハンドルを格納するグローバル変数
static GLuint sphereVBO;
static GLuint sphereIBO;

// 頂点のデータ構造を定義する構造体
typedef struct _Vertex {
    GLfloat x, y, z;
    GLfloat nx, ny, nz;
    GLfloat u, v;
} Vertex;


static void createSphere() {
    Vertex   sphereVertices[17 * 9];
    GLushort sphereIndices[3 * 32 * 8];
    
    // 頂点データを生成
    Vertex* vertex = sphereVertices;
    for(int i = 0 ; i <= 8 ; ++i) {
        GLfloat v = i / 8.0f;
        GLfloat y = cosf(M_PI * v);
        GLfloat r = sinf(M_PI * v);
        for(int j = 0 ; j <= 16 ; ++j) {
            GLfloat u = j / 16.0f;
            Vertex data = {
                cosf(2 * M_PI * u) * r,  y, sinf(2 * M_PI * u) * r, // 座標
                cosf(2 * M_PI * u) * r,  y, sinf(2 * M_PI * u) * r, // 法線
                u, v                                                // UV
            };
            *vertex++ = data;
        }
    }
    
    // インデックスデータを生成
    GLushort* index = sphereIndices;
    for(int j = 0 ; j < 8 ; ++j) {
        int base = j * 17;
        for(int i = 0 ; i < 16 ; ++i) {
            *index++ = base + i;
            *index++ = base + i + 1;
            *index++ = base + i + 17;
            *index++ = base + i + 17;
            *index++ = base + i + 1;
            *index++ = base + i + 1 + 17;
        }
    }
    
    // VBOを作成
    GLuint buffers[2];
    glGenBuffers(2, buffers);
    sphereVBO = buffers[0];
    sphereIBO = buffers[1];
    
    // VBOを初期化し、データをコピー。
    glBindBuffer(GL_ARRAY_BUFFER, sphereVBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(sphereVertices),sphereVertices,GL_STATIC_DRAW);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    // IBOを初期化し、データをコピー。
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, sphereIBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(sphereIndices), sphereIndices, GL_STATIC_DRAW);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

// テクスチャのハンドルを格納するグローバル変数
static GLuint earthTexture;

static void loadTexture() {
    // 画像を読み込み、 32bit RGBA フォーマットのデータを取得
    CGImageRef image  = [UIImage imageNamed:@"earth.jpg"].CGImage;
    NSInteger  width  = CGImageGetWidth(image);
    NSInteger  height = CGImageGetHeight(image);
    GLubyte*   bits   = (GLubyte*)malloc(width * height * 4);
    CGContextRef textureContext =
    CGBitmapContextCreate(bits, width, height, 8, width * 4,
                          CGImageGetColorSpace(image), kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, width, height), image);
    CGContextRelease(textureContext);
    
    // テクスチャを作成し、データを転送
    glGenTextures(1, &earthTexture);
    glBindTexture(GL_TEXTURE_2D, earthTexture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, bits);
    glBindTexture(GL_TEXTURE_2D, 0);
    free(bits);
}

static void drawScene(GLfloat screenWidth, GLfloat screenHeight) {
    // ライトとマテリアルの設定
    const GLfloat lightPos[]     = { 1.0f, 1.0f, 1.0f, 0.0f };
    const GLfloat lightColor[]   = { 1.0f, 1.0f, 1.0f, 1.0f };
    const GLfloat lightAmbient[] = { 0.0f, 0.0f, 0.0f, 1.0f };
    const GLfloat diffuse[]      = { 0.7f, 0.7f, 0.7f, 1.0f };
    const GLfloat ambient[]      = { 0.3f, 0.3f, 0.3f, 1.0f };
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, lightColor);
    glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, diffuse);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, ambient);
    
    // シーンの射影行列を設定
    glMatrixMode(GL_PROJECTION);
    const GLfloat near  = 0.1f, far = 1000.0f;
    const GLfloat aspect = screenWidth / screenHeight;
    const GLfloat width = near * tanf(M_PI * 60.0f / 180.0f / 2.0f);
    glLoadIdentity();
    glFrustumf(-width, width, -width / aspect, width / aspect, near, far);
    
    // 球体の変換行列を設定
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0, 0.0, -3.0);
    
    // 頂点データを設定
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_NORMAL_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
    glBindBuffer(GL_ARRAY_BUFFER, sphereVBO);
    
    glVertexPointer(3, GL_FLOAT, sizeof(Vertex), 0);
    glNormalPointer(GL_FLOAT, sizeof(Vertex), (GLvoid*)(sizeof(GLfloat)*3));
    glTexCoordPointer(2, GL_FLOAT, sizeof(Vertex), (GLvoid*)(sizeof(GLfloat)*6));
    
    // インデックスデータを設定
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, sphereIBO);
    
    // テクスチャを設定して、双線形補完を有効にする
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, earthTexture);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    
    // 球体を回転させる
    static GLfloat angle = 0.0f;
    angle += 1.0f;
    glRotatef(angle, 0.0f, 1.0f, 0.0f);
    
    // 球体を描画
    glDrawElements(GL_TRIANGLES, 3 * 32 * 8, GL_UNSIGNED_SHORT, 0);
    
    // bindを解除
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    glBindTexture(GL_TEXTURE_2D, 0);
}

@implementation GLView

// 回転と拡大を同時に許可
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)rotationGesture:(UIRotationGestureRecognizer *)gesture {
    
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gesture {
//    if(!_isMoving && gesture.state == UIGestureRecognizerStateBegan) {
//        _isMoving = YES;
//        _currentTransform = self.transform;
//    } else if(_isMoving && gesture.state == UIGestureRecognizerStateEnded) {
//        _isMoving = NO;
//        _scale = 1.0f;
//        _angle = 1.0f;
//    }
//    _scale = gesture.scale;
//    
//    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformConcat(_currentTransform, CGAffineTransformMakeRotation(_angle)), CGAffineTransformMakeScale(_scale, _scale));
//    gesture.view.transform = transform;
    
    
    // ピンチジェスチャー発生時に、Imageの現在のアフィン変形の状態を保存する
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _currentTransform = gesture.view.transform;
        // currentTransFormは、フィールド変数。imgViewは画像を表示するUIImageView型のフィールド変数。
    }
	
    // ピンチジェスチャー発生時から、どれだけ拡大率が変化したかを取得する
    // 2本の指の距離が離れた場合には、1以上の値、近づいた場合には、1以下の値が取得できる
    _scale = [gesture scale];
    
    // ピンチジェスチャー開始時からの拡大率の変化を、imgViewのアフィン変形の状態に設定する事で、拡大する。
    gesture.view.transform = CGAffineTransformConcat(_currentTransform, CGAffineTransformMakeScale(_scale, _scale));

}

// お約束
// iOS OpenGL ESプログラミングガイド
// https://developer.apple.com/jp/devcenter/ios/library/documentation/OpenGLES_ProgrammingGuide.pdf
+ (Class)layerClass
{
	return [ CAEAGLLayer class ];
}

- (id)initWithFrame:(CGRect)frame
//- (id)initWithCoder:(NSCoder *)aDecoder 
{
    self = [super initWithFrame:frame];
    
    if(self) {
        // Initialization code
//        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGesture:)];
//        rotation.delegate = self;
//        [self addGestureRecognizer:rotation];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
        pinch.delegate = self;
        [self addGestureRecognizer:pinch];
        
        CAEAGLLayer * pGLLayer = (CAEAGLLayer *)self.layer;
        pGLLayer.opaque = YES;
        
        // 描画後レンダバッファの内容を保持しない。
        // カラーレンダバッファの1ピクセルあたりRGBAを8bitずつ保持する
        pGLLayer.drawableProperties = [ NSDictionary dictionaryWithObjectsAndKeys:
                                       [ NSNumber numberWithBool:FALSE ],
                                       kEAGLDrawablePropertyRetainedBacking,
                                                                            kEAGLColorFormatRGBA8,
                                       kEAGLDrawablePropertyColorFormat,
                                       nil ];

        
        mpGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        [EAGLContext setCurrentContext:mpGLContext];
        
        // フレームバッファ作成
        glGenFramebuffersOES(1, &mFrameBuffer);
        glBindFramebufferOES(GL_FRAMEBUFFER_OES, mFrameBuffer);
        
        // カラーバッファ作成
        glGenRenderbuffersOES(1, &mColorBuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, mColorBuffer);

        // レンダーバッファの描画先をレイヤーに設定する(これをやった後でないと描画領域のサイズが取得できない)
        [mpGLContext renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:pGLLayer];
        
        // カラーバッファをフレームバッファに関連づける
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, mColorBuffer);
        
        // 現在の(カラー)？レンダーバッファから幅と高さを取得
        glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH, &backingWidth);
        glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT, &backingHeight);

        // 深度バッファ作成
        glGenRenderbuffersOES(1, &mDepthBuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, mDepthBuffer);
        
        // 深度バッファの保存先を作成
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        
        // 深度バッファをフレームバッファと関連づける
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, mDepthBuffer);
        
        // フレームバッファのチェック
        if(glCheckFramebufferStatus(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
            NSLog(@"エラー");
        }
        
        createSphere();
        loadTexture();
    }
    
    return self;
}

// 前処理
- (void)BeginScene {
    // 画面をクリア
    glViewport(0, 0, backingWidth, backingHeight);
    glClearColor(0.3f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);

    [EAGLContext setCurrentContext:mpGLContext];
    
    // フレームバッファをバインド
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, mFrameBuffer);
}

// 描画処理
- (void)drawScene {
    drawScene(backingWidth, backingHeight);

}

// 後処理
- (void)EndScene {
    // カラーバッファをバインドする
    // なぜかこれがないとだめ
    // ここまでフレームバッファ、レンダーバッファの処理をした後に、最後にコンテキスト(レイヤー)への表示をするために必要？
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, mColorBuffer);
    
    // 画面表示
    [mpGLContext presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)dealloc {
    glDeleteFramebuffers(1, &mFrameBuffer);
    glDeleteRenderbuffers(1, &mColorBuffer);
    glDeleteRenderbuffers(1, &mDepthBuffer);
}

@end
