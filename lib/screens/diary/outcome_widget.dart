import 'package:flutter/material.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/test.dart';
import 'package:tuple/tuple.dart';

abstract class OutcomeWidget {
  Widget createTileTestOutcome(
    BuildContext context,
    Tuple2<String,Test> test,
    Function(Map<String, dynamic> values) onUpdateTest,
  );

  Widget createSuggestedTileTestOutcome();

  Widget createOutcomeFormInput(
    BuildContext context,
    ReservableTest test,
  );
}
