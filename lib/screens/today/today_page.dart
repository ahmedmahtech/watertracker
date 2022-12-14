import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:watertracker/model/app_state.dart';
import 'package:watertracker/screens/home/widgets/drink_menu.dart';
import 'package:watertracker/screens/home/widgets/water_progress.dart';
import 'package:watertracker/util/utils.dart';
import 'package:watertracker/widgets/shadow/shadow_text.dart';


class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        SafeArea(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all( 0.0),
                      child: Text(
                        'TODAY',

                        style: TextStyle(
                            color: const Color(0xBEffffff),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text(
                        'Last 3 drinks',

                        style: TextStyle(
                            color: const Color(0xbee0dcdc),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: _TodayHistory(),
                    ),
                    Expanded(
                      child: WaterProgress(),
                    ),
                  ],
                ))),
        Positioned(
            bottom: 0.0,
            height: 160.0,
            child: SizedBox(
              width: size.width,
              height: 160.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.3, 0.7],
                      colors: [Colors.white.withOpacity(0.0), Colors.white]),
                ),
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 48.0),
              child: Center(child: DrinkMenu()),
            )
          ],
        ),
      ],
    );
  }
}

class _TodayHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        var historyText = '\nYou have not drunk anything today yet!\n';
        var todayEntries = state.drinksHistory
            .where((entry) =>
            Utils.isToday(DateTime.fromMillisecondsSinceEpoch(entry.date!)))
            .toList();

        if (todayEntries.length > 0) {
          todayEntries.sort((a, b) => b.date!.compareTo(a.date!));
          var i = 0;
          historyText = '';
          for (var entry in todayEntries) {
            historyText = DateFormat('HH:mm')
                .format(DateTime.fromMillisecondsSinceEpoch(entry.date!)) +
                ' - ${entry.amount} ml' +
                historyText;
            i++;

            if (i <3) {
              historyText = '\n' + historyText;
            } else {
              break;
            }
          }

          if (i < 3) {
            for (var index = 1; index < 3 - i; index++) {
              historyText = '\n' + historyText;
            }
          }
        }

        return Text(
          historyText,

          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
        );
      },
    );
  }
}
