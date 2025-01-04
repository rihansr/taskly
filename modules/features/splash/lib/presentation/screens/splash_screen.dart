import 'dart:async';
import 'package:core/configs/app_config.dart';
import 'package:core/router/routes.dart';
import 'package:core/utils/debug.dart';
import 'package:core/utils/encryptor.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:core/styles/styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    if (sl<SharedPrefs>().token == null) {
      sl<SharedPrefs>().token = appConfig.config['auth_token'];
    }
    _timer = Timer(kSplashTimeout, _navigateTo);
    super.initState();
  }

  _navigateTo() => context.router.pushReplacementNamed(Routes.dashboard);

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Backdrop(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 32),
            SvgPicture.asset(
              drawable.splashLogo,
              width: dimen.width / 2,
            ),
            LottieBuilder.asset(
              drawable.loading,
              width: 72,
              height: 72,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
