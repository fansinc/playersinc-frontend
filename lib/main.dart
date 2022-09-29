/*
PlayersInc Mobile App, United Kingdom
Copyright (c) 2022, PlayersInc

Developed by Santhosh, Yunesg Ind Tech
https://www.hridhamtech.com
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'config/app_config.dart';

//Providers

import 'providers/auth_provider.dart';
import 'providers/challenges_provider.dart';
import 'providers/concussion_provider.dart';
import 'providers/concussion_recovery_info_provider.dart';
import 'providers/experiences_provider.dart';
import 'providers/injury_provider.dart';
import 'providers/log_time_provider.dart';
import 'providers/missions_provider.dart';
import 'providers/my_top_play_provider.dart';
import 'providers/my_week_provider.dart';
import 'providers/register_provider.dart';
import 'providers/news_provider.dart';
import 'providers/purchase_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/clubs_provider.dart';
import 'providers/positions_provider.dart';
import 'providers/skills_provider.dart';
import 'providers/symptoms_provider.dart';

//Pages
import 'pages/skills_page.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/health_check_page.dart';
import 'pages/notificiation_page.dart';
import 'pages/healthy_mind_page.dart';
import 'pages/log_injury_page.dart';
import 'pages/challenges_page.dart';
//import 'pages/auth_page.dart';
import 'pages/email_auth_page.dart';
import 'pages/register_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/profile_page.dart';
import 'pages/concussion_recovery_page.dart';
import 'pages/concussion_page.dart';
import 'pages/injury_data_page.dart';
import 'pages/session_data_page.dart';
import 'pages/my_top_play_page.dart';
import 'pages/challenge_submit_page.dart';
import 'pages/missions_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set Orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /* // Set Safe Area Color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    // Colors.white, // Only honored in Android M and above
      statusBarIconBrightness:
        Brightness.dark, // Only honored in Android M and above
    statusBarBrightness: Brightness.light, 
  ));*/

  runApp(const PlayersInc());
}

class PlayersInc extends StatefulWidget {
  const PlayersInc({Key? key}) : super(key: key);

  @override
  _PlayersIncState createState() => _PlayersIncState();
}

class _PlayersIncState extends State<PlayersInc> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AuthProvider()),
          ChangeNotifierProvider(create: (ctx) => RegisterProvider()),
          ChangeNotifierProvider(create: (ctx) => NewsProvider()),
          ChangeNotifierProvider(create: (ctx) => ExperiencesProvider()),
          ChangeNotifierProvider(create: (ctx) => MyWeekProvider()),
          ChangeNotifierProvider(create: (ctx) => PurchaseProvider()),
          ChangeNotifierProvider(create: (ctx) => ProfileProvider()),
          ChangeNotifierProvider(create: (ctx) => ClubsProvider()),
          ChangeNotifierProvider(create: (ctx) => PositionsProvider()),
          ChangeNotifierProvider(create: (ctx) => SymptomsProvider()),
          ChangeNotifierProvider(create: (ctx) => InjuryProvider()),
          ChangeNotifierProvider(create: (ctx) => LogTimeProvider()),
          ChangeNotifierProvider(create: (ctx) => ConcussionProvider()),
          ChangeNotifierProvider(
              create: (ctx) => ConcussionRecoveryInfoProvider()),
          ChangeNotifierProvider(create: (ctx) => MyTopPlayProvider()),
          ChangeNotifierProvider(create: (ctx) => ChallengesProvider()),
          ChangeNotifierProvider(create: (ctx) => SkillsProvider()),
          ChangeNotifierProvider(create: (ctx) => MissionsProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          routes: {
            //AuthPage.routeName: (ctx) => const AuthPage(),
            EmailAuthPage.routeName: (ctx) => const EmailAuthPage(),
            RegisterPage.routeName: (ctx) => const RegisterPage(),
            ForgotPasswordPage.routeName: (ctx) => const ForgotPasswordPage(),
            HomePage.routeName: (ctx) => const HomePage(),
            HealthCheckPage.routeName: (ctx) => const HealthCheckPage(),
            ChallengesPage.routeName: (ctx) => const ChallengesPage(),
            HealthyMindPage.routeName: (ctx) => const HealthyMindPage(),
            NotificationPage.routeName: (ctx) => const NotificationPage(),
            LogInjuryPage.routeName: (ctx) => const LogInjuryPage(),
            ProfilePage.routeName: (ctx) => const ProfilePage(),
            ConcussionRecoveryPage.routeName: (ctx) =>
                const ConcussionRecoveryPage(),
            ConcussionPage.routeName: (ctx) => const ConcussionPage(),
            InjuryDataPage.routeName: (ctx) => const InjuryDataPage(),
            SessionDataPage.routeName: (ctx) => const SessionDataPage(),
            MyTopPlayPage.routeName: (ctx) => const MyTopPlayPage(),
            SkillsPage.routeName: (ctx) => const SkillsPage(),
            ChallengeSubmitPage.routeName: (ctx) => const ChallengeSubmitPage(),
            MissionsPage.routeName: (ctx) => const MissionsPage(),
            /*  ProfileEditPage.routeName: (ctx) => ProfileEditPage(), */
          },
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              // Set backwardsCompatibility to false
              // to tell the system that we are going to use systemOverlayStyle not brightness
              //backwardsCompatibility: false,

              // Use systemOverlayStyle to control status bar text color.
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              // SystemUiOverlayStyle.dark means System overlays text should be drawn with a dark color.
              // Intended for applications with a light background.

              // SystemUiOverlayStyle.light means System overlays text should be drawn with a light color.
              // Intended for applications with a dark background.
            ),
            primaryColor: const Color(AppConfig.blueColor),
            fontFamily: 'NunitoSans',
            primaryTextTheme: const TextTheme(
              headline1: TextStyle(fontSize: 14),
            ),
          ),
        ));
  }
}
