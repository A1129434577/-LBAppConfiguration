# LBAppConfiguration
项目登录模块组件化，免去了一些重复且复杂设置，支持任意第三方推送，支持游客模式，只需要设置LoginController类名以及HomeController类名，内含需要集成的第三方库快速配置，省去了其他一些复杂的代码，一键设置，更快更方便。
# pod安装
```ruby
pod 'LBAppConfiguration'
```

# 使用方法
```Objc
//设置登录控制器类
[LBAppConfiguration shareInstanse].loginVCClass = LoginViewController.class;
//如果需要设置登录导航控制器类
[LBAppConfiguration shareInstanse].loginNaVCClass = UINavigationController.class;
//设置主界面类
[LBAppConfiguration shareInstanse].homeVCClass = TabBarViewController.class;
//如果需要设置主界面导航控制器类
//[LBAppConfiguration shareInstanse].homeVCNaClass = UINavigationController.class;
//是否支持游客模式
[LBAppConfiguration shareInstanse].touristPattern = YES;
//开始登录，loginInfo为基本用户信息
[LBAppConfiguration tryLoginWithNewLoginInfo:nil];
```
