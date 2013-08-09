//
//  HttpViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/07.
//
//

#import "HttpViewController.h"

@interface HttpViewController ()

@end

@implementation HttpViewController
@synthesize txtUrl;
@synthesize lblResponse;
@synthesize scvResponse;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    txtUrl.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapGet:(id)sender {
    [txtUrl resignFirstResponder];
    [lblResponse setText:@""];
    [self accessUrlAsync:[NSURL URLWithString:txtUrl.text]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [txtUrl resignFirstResponder];
    [lblResponse setText:@""];
    [self accessUrlAsync:[NSURL URLWithString:txtUrl.text]];
    return YES;
}

- (void)accessUrl:(NSURL*)url {
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    NSHTTPURLResponse * response;
    NSError * error;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    strResponse = [NSMutableString string];
    // ヘッダ部
    {
        NSDictionary *headerInfo = ((NSHTTPURLResponse *)response).allHeaderFields;
        [strResponse appendFormat:@"%d %@\n", response.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]];
        for(id key in [headerInfo keyEnumerator]) {
            [strResponse appendFormat:@"%@: %@\n", key, [headerInfo valueForKey:key]];
        }
    }
    
    // BODY部
    {
        NSString *encodingName = [[response textEncodingName] lowercaseString];
        encodingName = [[encodingName componentsSeparatedByString:@"-"] componentsJoinedByString:@""];
        encodingName = [[encodingName componentsSeparatedByString:@"_"] componentsJoinedByString:@""];
        
        NSStringEncoding encoding;
        if ([encodingName isEqualToString:@"eucjp"]) {
            encoding = NSJapaneseEUCStringEncoding;
        } else if ([encodingName isEqualToString:@"shiftjis"] || [encodingName isEqualToString:@"sjis"]) {
            encoding = NSShiftJISStringEncoding;
        } else {
            encoding = NSUTF8StringEncoding;
        }
        NSString *sData = [[NSString alloc] initWithData:data encoding:encoding];
        
        [strResponse appendFormat:@"---Body----------\n"];
        [strResponse appendFormat:@"%@\n", sData];
    }
    
    // ラベルとスクロールの調整
    [lblResponse setText:strResponse];
    CGRect frame = lblResponse.frame;
    frame.size = [strResponse sizeWithFont:lblResponse.font constrainedToSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 10000) lineBreakMode:NSLineBreakByTruncatingTail];
    [lblResponse setFrame:frame];
    [scvResponse setContentSize:lblResponse.frame.size];
}

- (void)accessUrlAsync:(NSURL*)url {
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"Host" forHTTPHeaderField:@"aaaa"];
    [request setValue:@"Accept-Language" forHTTPHeaderField:@"ja-jp"];
    [request setValue:@"Accept" forHTTPHeaderField:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request setValue:@"http://www.google.co.jp" forHTTPHeaderField:@"X-MobileIron-App-OriginalURL"];
    [request setValue:@"NS Solutions" forHTTPHeaderField:@"X-MobileIron-SecureBrowser-Managed-By"];
    [request setValue:@"1111111111" forHTTPHeaderField:@"X-MobileIron-App-DeviceUuid"];
    [request setValue:@"koreha dummy" forHTTPHeaderField:@"X-MobileIron-AC-Tunneling"];
    [request setValue:@"testwww" forHTTPHeaderField:@"X-MobileIron-App-ServiceName"];
    [request setValue:@"test" forHTTPHeaderField:@"X-MobileIron-App-UserName"];
    [request setValue:@"test dev" forHTTPHeaderField:@"X-MobileIron-App-DeviceModel"];
    [request setValue:@"1" forHTTPHeaderField:@"X-MobileIron-App-TunnelVersion"];
    [request setValue:@"aaa" forHTTPHeaderField:@"X-MobileIron-Name"];
    [request setValue:@"12345" forHTTPHeaderField:@"X-MobileIron-ConfiguUuid"];
    [request setValue:@"jp.co.test" forHTTPHeaderField:@"X-MobileIron-ConfiguBundleId"];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    responseHead = nil;
    strResponse = [NSMutableString string];
    receiveData = [NSMutableData data];
}

// エラー時
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}

// ヘッダ受信時
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    responseHead = (NSHTTPURLResponse *)response;
}

// BODY受信時(複数回呼ばれる場合がある)
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"didReceiveData");
    [receiveData appendData:data];
}

// 通信終了時
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    
    NSDictionary *headerInfo = responseHead.allHeaderFields;
    [strResponse appendFormat:@"%d %@\n", responseHead.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:responseHead.statusCode]];
    for(id key in [headerInfo keyEnumerator]) {
        [strResponse appendFormat:@"%@: %@\n", key, [headerInfo valueForKey:key]];
    }
    
    {
        NSString *encodingName = [[responseHead textEncodingName] lowercaseString];
        encodingName = [[encodingName componentsSeparatedByString:@"-"] componentsJoinedByString:@""];
        encodingName = [[encodingName componentsSeparatedByString:@"_"] componentsJoinedByString:@""];
        
        NSStringEncoding encoding;
        if ([encodingName isEqualToString:@"eucjp"]) {
            encoding = NSJapaneseEUCStringEncoding;
        } else if ([encodingName isEqualToString:@"shiftjis"] || [encodingName isEqualToString:@"sjis"]) {
            encoding = NSShiftJISStringEncoding;
        } else {
            encoding = NSUTF8StringEncoding;
        }
        NSString *sData = [[NSString alloc] initWithData:receiveData encoding:encoding];
        
        [strResponse appendFormat:@"---Body----------\n"];
        [strResponse appendFormat:@"%@\n", sData];
    }
    
    
    // ラベルとスクロールの調整
    [lblResponse setText:strResponse];
    CGRect frame = lblResponse.frame;
    frame.size = [strResponse sizeWithFont:lblResponse.font constrainedToSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 10000) lineBreakMode:NSLineBreakByTruncatingTail];
    [lblResponse setFrame:frame];
    [scvResponse setContentSize:lblResponse.frame.size];
}

//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
//    NSLog(@"canAuthenticateAgainstProtectionSpace");
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"willSendRequestForAuthenticationChallenge");
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    } else if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate]) {
        
        //this handles authenticating the client certificate
        /*
         What we need to do here is get the certificate and an an identity so we can do this:
         NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:myCerts persistence:NSURLCredentialPersistencePermanent];
         [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
         It's easy to load the certificate using the code in -installCertificate
         It's more difficult to get the identity.
         We can get it from a .p12 file, but you need a passphrase:
         */
        /*
        NSString *p12Path = [[NSBundle mainBundle] pathForResource:@"client.p12" ofType:@"p12"];
        NSData *p12Data = [[NSData alloc] initWithContentsOfFile:p12Path];
        
        CFStringRef password = CFSTR("PASSWORD");
        const void *keys[] = { kSecImportExportPassphrase };
        const void *values[] = { password };
        CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
        CFArrayRef p12Items;
        
        OSStatus result = SecPKCS12Import((CFDataRef)p12Data, optionsDictionary, &p12Items);
        if(result == noErr) {
            CFDictionaryRef identityDict = CFArrayGetValueAtIndex(p12Items, 0);
            SecIdentityRef identityApp =(SecIdentityRef)CFDictionaryGetValue(identityDict,kSecImportItemIdentity);
            
            SecCertificateRef certRef;
            SecIdentityCopyCertificate(identityApp, &certRef);

            SecCertificateRef certArray[1] = { certRef };
            CFArrayRef myCerts = CFArrayCreate(NULL, (void *)certArray, 1, NULL);
            CFRelease(certRef);

            NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identityApp certificates:(NSArray *)certRef persistence:NSURLCredentialPersistencePermanent];
            CFRelease(myCerts);

            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        }
         */
        /*
        // 証明書(p12)ファイルを読み込み
        NSString *path = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
        NSData *pfxdata = [NSData dataWithContentsOfFile:path];
        CFDataRef inpfxdata = (__bridge CFDataRef)pfxdata;
        
        // 証明書データから秘密鍵と証明書を抽出
        SecIdentityRef myIdentity;
        SecTrustRef myTrust;
        OSStatus status = extractIdentityAndTrust(inpfxdata, &myIdentity, &myTrust);
        
        SecCertificateRef myCertificate;
        SecIdentityCopyCertificate(myIdentity, &myCertificate);
        const void *certs[] = { myCertificate };
        CFArrayRef certsArray = CFArrayCreate(NULL, certs, 1, NULL);
        NSURLCredential *credential = [NSURLCredential credentialWithIdentity:myIdentity
                                                                 certificates:(__bridge NSArray *)myCertificate
                                                                  persistence:NSURLCredentialPersistencePermanent];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        CFRelease(myIdentity);
        CFRelease(myCertificate);
        CFRelease(certsArray);
        */
        
        NSLog(@"Trying Certificate");
        // load cert
        
        // 証明書(p12)ファイルを読み込み
        NSString *thePath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
        NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
        CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
        
        // 証明書データから秘密鍵と証明書を抽出
        OSStatus status = noErr;
        SecIdentityRef myIdentity;
        SecTrustRef myTrust;
        status = extractIdentityAndTrust(inPKCS12Data, &myIdentity, &myTrust);
        
        SecTrustResultType trustResult;
        if (status == noErr) {
            status = SecTrustEvaluate(myTrust, &trustResult);
        }
        
        SecCertificateRef myCertificate;
        SecIdentityCopyCertificate(myIdentity, &myCertificate);
        const void *certs[] = { myCertificate };
        CFArrayRef certsArray = CFArrayCreate(NULL, certs, 1, NULL);
        
        
        NSURLCredential *credential = [NSURLCredential credentialWithIdentity:myIdentity certificates:(__bridge NSArray*)certsArray persistence:NSURLCredentialPersistencePermanent];
        
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
         
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

OSStatus extractIdentityAndTrust(CFDataRef inP12data, SecIdentityRef *identity, SecTrustRef *trust)
{
    OSStatus securityError = errSecSuccess;
    
    CFStringRef password = CFSTR("Pioap123");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12data, options, &items);
    
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemTrust);
        *trust = (SecTrustRef)tempTrust;
    }
    
    if (options) {
        CFRelease(options);
    }
    
    return securityError;
}

- (void)viewDidUnload {
    [self setTxtUrl:nil];
    [self setLblResponse:nil];
    [self setScvResponse:nil];
    [super viewDidUnload];
}
@end
