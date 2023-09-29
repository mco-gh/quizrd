import 'package:flutter/material.dart';
import 'package:quizaic/const.dart';
import 'package:pinput/pinput.dart';
import 'package:quizaic/models/state.dart';
import 'package:quizaic/views/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:quizaic/views/helpers.dart';
import 'package:bad_words/bad_words.dart';
import 'package:go_router/go_router.dart';
import 'package:quizaic/views/quiz.dart';

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: Color(0xfff68d2d)),
    borderRadius: BorderRadius.circular(20),
  ),
);

class PlayPage extends StatelessWidget {
  final _controller = TextEditingController();
  final filter = Filter();
  final String? pin;

  PlayPage({this.pin});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    var theme = Theme.of(context);

    //badPinOnDeepLink(pin) {
    //errorDialog('No session available for pin $pin');
    //GoRouter.of(context).go('/play');
    //}

    badPinOnPlayForm(pin) {
      errorDialog('No session available for pin $pin');
      GoRouter.of(context).go('/play');
    }

    checkAndRegisterPlayerName(name) async {
      print('checkAndRegisterPlayerName($name)');
      bool profane = filter.isProfane(name);
      if (profane) {
        errorDialog('Invalid name, please try again.');
        _controller.setText('');
        return;
      }
      appState.registerPlayer(name);
    }

    // if a pin was provided by url and we haven't yet found
    // a session for it, try to do so here.
    // if (pin != null && pin != '' && !appState.sessionFound) {
    // appState.findSessionByPin(pin, badPinOnDeepLink);
    // Can't do this yet because don't know if session found,
    // since that's done async.
    //String? name = appState.getPlayerNameByPinFromLocal(pin);
    //if (name != null) {
    //return QuizPage();
    //}
    // }

    if (appState.playerData.pin != '' && appState.playerData.playerName != '') {
      return QuizPage();
    }

    String quizName = 'N/A (no quiz started yet for this session)';
    String quizImage = 'assets/images/logo.png';
    if (appState.playerData.quiz != null) {
      quizName = appState.playerData.quiz?.name as String;
      quizImage = appState.playerData.quiz?.imageUrl as String;
    }
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: verticalSpaceHeight * 2),
                    genText(
                      theme,
                      'Enter a PIN to play a quiz or complete a survey:',
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: verticalSpaceHeight * 2),
                    Pinput(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: TextEditingController(),
                      length: 3,
                      defaultPinTheme: defaultPinTheme,
                      validator: (s) {
                        appState.findSessionByPin(s, badPinOnPlayForm);
                        return null;
                      },
                    ),
                    SizedBox(height: verticalSpaceHeight * 3),
                    if (appState.playerData.pin != '')
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(children: [
                                SizedBox(height: verticalSpaceHeight * 3),
                                Image.network(
                                  quizImage,
                                  height: logoHeight,
                                ),
                                SizedBox(width: horizontalSpaceWidth),
                                genText(
                                  theme,
                                  'Quiz Name: $quizName',
                                  weight: FontWeight.bold,
                                ),
                              ]),
                            ],
                          ),
                          SizedBox(height: verticalSpaceHeight * 3),
                          SizedBox(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(formPadding),
                              child: TextField(
                                controller: _controller,
                                onSubmitted: (name) =>
                                    checkAndRegisterPlayerName(name),
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: "Name",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: verticalSpaceHeight),
                          ElevatedButton(
                              onPressed: () => {
                                    if (_controller.value.text.isEmpty)
                                      {
                                        errorDialog(
                                          'Please enter a name to play the quiz or complete the survey.',
                                        ),
                                      }
                                    else
                                      {
                                        checkAndRegisterPlayerName(
                                          _controller.value.text,
                                        )
                                      }
                                  },
                              child: genText(theme,
                                  'Play ${appState.sessionData.survey ? 'Survey' : 'Quiz'}')),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
