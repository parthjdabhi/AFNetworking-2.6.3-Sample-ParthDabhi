//
//  ViewController.m
//  AFNetworking2.6.3_Sample
//
//  Created by IBL Infotech on 08/06/16.
//  Copyright © 2016 IBL Infotech. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSimplePost:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *jsonData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"value",@"key",
                                     @"value",@"key",
                                     nil];
    
    [manager POST:@"Url Of API" parameters:jsonData
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [hud hide:YES];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@",error);
        [hud hide:YES];
    }];
    
}

- (IBAction)btnMultipartData:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    NSMutableDictionary *jsonData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"value",@"key",
                                     @"value",@"key",
                                     nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager POST:@"Url Of API" parameters:jsonData constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         NSData *data=UIImageJPEGRepresentation(self.imageview.image, 0.5);
             [formData appendPartWithFileData:data name:@"Key Of Image" fileName:@"profilepic.jpg" mimeType:@"image/jpeg"];
         
     }
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSLog(@"%@",responseObject);
          [hud hide:YES];
          
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error : %@",error);
          [hud hide:YES];
      }];
    
}

- (IBAction)btnImageDownload:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"Url Of Image" parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *returnData)
     {
         [UIView transitionWithView:self.imageview
                           duration:0.5f
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^
          {
              self.imageview.image = [UIImage imageWithData:returnData];
          } completion:NULL];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error.description);
     }];

    
}
@end
