import 'package:flutter/material.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class LoadingWidget extends StatelessWidget {
  final String message;

  final bool useLoader;
  final double size;
  const LoadingWidget({Key key, this.message, this.useLoader = false, this.size = 42.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useLoader? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Loading(indicator: BallPulseIndicator(), size: size,color: Theme.of(context).primaryColor),
        SizedBox(height: 16),
        Text(message ?? lang.text("Loading"))
      ],
    ): Row(
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(width: 16),
        Expanded(child: Text(message ?? lang.text("Loading"))),
      ],
    );
  }
}
