import 'package:material_ui/material_ui.dart';

import 'app_theme.dart';
import 'dashboard_page.dart';
import 'login_page.dart';
import 'rooms/rooms.dart';
import 'signup_page.dart';

void main() => runApp(const HotelDemoApp());

class HotelDemoApp extends StatelessWidget {
  const HotelDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Suites',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: SignupPage.routeName,
      routes: <String, WidgetBuilder>{
        SignupPage.routeName: (BuildContext context) => const SignupPage(),
        LoginPage.routeName: (BuildContext context) => const LoginPage(),
        DashboardPage.routeName: (BuildContext context) =>
            const DashboardPage(),
        RoomListPage.routeName: (BuildContext context) => const RoomListPage(),
      },
    );
  }
}
