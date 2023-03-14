import 'package:chatcine/common/middlewares/middlewares.dart';
import 'package:chatcine/pages/contactScreen/index.dart';
import 'package:chatcine/pages/profileScreen/index.dart';
import 'package:chatcine/pages/signinScreen/index.dart';
import 'package:chatcine/pages/messageScreen/index.dart';
import 'package:chatcine/pages/wellcomeScreen/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // 免登陆
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WellcomePages(),
      binding: WellcomeBindings(),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPages(),
      binding: SignInBindings(),
    ),

    // 需要登录
    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),
    // // 最新路由
    // GetPage(name: AppRoutes.EmailLogin, page: () => EmailLoginPage(), binding: EmailLoginBinding()),
    // GetPage(name: AppRoutes.Register, page: () => RegisterPage(), binding: RegisterBinding()),
    // GetPage(name: AppRoutes.Forgot, page: () => ForgotPage(), binding: ForgotBinding()),
    // GetPage(name: AppRoutes.Phone, page: () => PhonePage(), binding: PhoneBinding()),
    // GetPage(name: AppRoutes.SendCode, page: () => SendCodePage(), binding: SendCodeBinding()),
    // 首页
    GetPage(
        name: AppRoutes.Contact,
        page: () => const ContactPages(),
        binding: ContactBindings()),
    //消息

    GetPage(
      name: AppRoutes.Message,
      page: () => const MessagePages(),
      binding: MessageBindings(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    // profile
    GetPage(
        name: AppRoutes.Profile,
        page: () => const ProfilePages(),
        binding: ProfileBindings()),
    // //聊天详情
    // GetPage(name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),

    // GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),
    // GetPage(name: AppRoutes.VoiceCall, page: () => VoiceCallViewPage(), binding: VoiceCallViewBinding()),
    // GetPage(name: AppRoutes.VideoCall, page: () => VideoCallPage(), binding: VideoCallBinding()),
  ];
}
