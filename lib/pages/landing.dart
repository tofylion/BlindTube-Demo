import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/styles/constants.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show
        GoogleAuthButton,
        AuthButtonStyle,
        AuthButtonType,
        AuthIconType,
        FacebookAuthButton,
        TwitterAuthButton;

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(
            flex: 7,
            child: SpringButton(
              SpringButtonType.OnlyScale,
              Image.asset('assets/images/BlindTubeLogo.png'),
              onTap: () {},
              useCache: false,
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'BLIND',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  'TUBE',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tappable(
                    child: FacebookAuthButton(
                      darkMode: true,
                      style: AuthButtonStyle(
                        // iconColor: Color(0xFF1778f2),
                        buttonType: AuthButtonType.icon,
                        buttonColor: lighterCardColor,
                      ),
                    ),
                  ),
                  Tappable(
                    child: TwitterAuthButton(
                      darkMode: true,
                      style: AuthButtonStyle(
                        // iconColor: Color(0xFF1DA1F2),
                        buttonType: AuthButtonType.icon,
                        buttonColor: lighterCardColor,
                      ),
                    ),
                  ),
                  Tappable(
                    child: GoogleAuthButton(
                      darkMode: true,
                      style: AuthButtonStyle(
                        buttonColor: lighterCardColor,
                        // iconColor: Color(0xFF1778f2),
                        buttonType: AuthButtonType.icon,
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 4,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
