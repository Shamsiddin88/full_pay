import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/auth/auth_bloc.dart';
import 'package:full_pay/blocs/auth/auth_event.dart';
import 'package:full_pay/blocs/user_cards/user_cards_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_event.dart';
import 'package:full_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:full_pay/data/repositories/auth_repository.dart';
import 'package:full_pay/data/repositories/cards_repository.dart';
import 'package:full_pay/data/repositories/user_profile_repository.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/services/local_notification_service.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (context) => UserProfileRepository()),
        RepositoryProvider(create: (context) => CardsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>())
                    ..add(CheckAuthenticationEvent())),
          BlocProvider(
              create: (context) =>
                  UserProfileBloc(context.read<UserProfileRepository>())),
          BlocProvider(
              create: (context) => UserCardsBloc(
                  cardsRepository: context.read<CardsRepository>())
                ..add(GetCardsDatabaseEvent())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
