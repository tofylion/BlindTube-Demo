import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/hero_control.dart';
import 'package:blindtube/pages/home_page.dart';
import 'package:blindtube/styles/constants.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:blindtube/testing/database.dart';
import 'package:flutter/material.dart';
import 'package:blindtube/secrets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:spring_button/spring_button.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show
        GoogleAuthButton,
        AuthButtonStyle,
        AuthButtonType,
        AuthIconType,
        FacebookAuthButton,
        TwitterAuthButton;
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int heroIndex = HeroControl.generateHeroIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(
            flex: 7,
            child: Hero(
              tag: 'logo' + heroIndex.toString(),
              child: SpringButton(
                SpringButtonType.OnlyScale,
                Image(
                  image: ResizeImage(
                    Image.asset('assets/images/BlindTubeLogo.png').image,
                    width: 1080,
                    allowUpscaling: true,
                  ),
                  width: 1080,
                ),
                onTap: () {},
                useCache: false,
              ),
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
                      onTap: () async {
                        final LoginResult result =
                            await FacebookAuth.instance.login();
                        if (result.status == LoginStatus.success) {
                          // you are logged
                          final AccessToken accessToken = result.accessToken!;
                          final userData =
                              await FacebookAuth.instance.getUserData();
                          Database.user.name =
                              (userData['name'] as String).split(' ')[0];

                          var page = await HeroControl.buildPageAsync(HomePage(
                            heroIndex: heroIndex,
                          ));

                          var route =
                              MaterialPageRoute(builder: (context) => page);
                          await Navigator.pushReplacement(context, route);
                        } else {
                          print(result.status);
                          print(result.message);
                        }
                      }),
                  Tappable(
                      child: TwitterAuthButton(
                        darkMode: true,
                        style: AuthButtonStyle(
                          // iconColor: Color(0xFF1DA1F2),
                          buttonType: AuthButtonType.icon,
                          buttonColor: lighterCardColor,
                        ),
                      ),
                      onTap: () async {
                        final TwitterLogin twitterLogin = TwitterLogin(
                          apiKey: twitterKey,
                          apiSecretKey: twitterKeySecret,
                          redirectURI: "blindtube://",
                        );
                        print(twitterLogin.apiSecretKey);
                        final authResult = await twitterLogin.loginV2();
                        if (authResult.status == TwitterLoginStatus.loggedIn) {
                          Database.user.name = authResult.user!.name;

                          var page = await HeroControl.buildPageAsync(HomePage(
                            heroIndex: heroIndex,
                          ));
                          var route =
                              MaterialPageRoute(builder: (context) => page);
                          Navigator.pushReplacement(context, route);
                        } else {
                          print(authResult.status);
                          print(authResult.errorMessage);
                        }
                      }),
                  Tappable(
                    child: GoogleAuthButton(
                      darkMode: true,
                      style: AuthButtonStyle(
                        buttonColor: lighterCardColor,
                        // iconColor: Color(0xFF1778f2),
                        buttonType: AuthButtonType.icon,
                      ),
                    ),
                    onTap: () async {
                      GoogleSignIn googleSignIn = GoogleSignIn.standard(
                        scopes: [
                          'https://www.googleapis.com/auth/userinfo.profile',
                        ],
                      );
                      try {
                        await googleSignIn.signIn();
                        print('signed in');
                        Database.user.name = googleSignIn
                            .currentUser!.displayName!
                            .split(' ')[0];
                        var page = await HeroControl.buildPageAsync(HomePage(
                          heroIndex: heroIndex,
                        ));
                        var route =
                            MaterialPageRoute(builder: (context) => page);
                        Navigator.pushReplacement(context, route);
                      } catch (error) {
                        print(error.toString());
                      }
                    },
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
