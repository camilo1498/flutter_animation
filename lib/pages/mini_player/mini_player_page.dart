import 'package:animations/pages/mini_player/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _navigatorKey = GlobalKey();

class MiniPlayerPage extends StatelessWidget {
  const MiniPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return SizedBox(
      width: screenUtil.screenWidth,
      height: screenUtil.screenHeight,
      child: Stack(
        children: [
          Navigator(
            key: _navigatorKey,
            onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) => Container(),
            ),
          ),
          Miniplayer(
            minHeight: 70,
            maxHeight: screenUtil.screenHeight,
            builder: (height, percentage) => Center(
              child: Text('$height, $percentage'),
            ),
          )
        ],
      ),
    );
  }
}