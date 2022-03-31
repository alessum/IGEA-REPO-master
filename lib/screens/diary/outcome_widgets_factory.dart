import 'package:flutter/material.dart';
import 'package:igea_app/models/enums/screening_outcome_value.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/diary/generic_outcome_input_form.dart';
import 'package:igea_app/screens/diary/ui_components/tile_generic_outcome.dart';
import 'package:igea_app/widgets/customExpansionTileBloodTestArchive.dart';
import 'package:igea_app/widgets/customExpansionTileScreeningArchive.dart';
import 'package:igea_app/screens/diary/outcome_widget.dart';
import 'package:igea_app/screens/diary/screening_outcome_input_form.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class OutcomeWidgetsFactory extends OutcomeWidget {
  static final OutcomeWidgetsFactory _factory =
      OutcomeWidgetsFactory._internal();
  OutcomeWidgetsFactory._internal();

  factory OutcomeWidgetsFactory.instance() {
    return _factory;
  }

  @override
  Widget createTileTestOutcome(
      BuildContext context,
      Tuple2<String, Test> testData,
      Function(Map<String, dynamic> values) onUpdateTest) {
    Test t = testData.item2;
    if (t.type == TestType.GENERIC_TEST) {
      return TileGenericOutcome(
          testData: testData, onUpdateOutcome: onUpdateTest);
    } else if (t.type == TestType.BLOOD_TEST ||
        t.type == TestType.CARDIO_TEST ||
        t.type == TestType.ECO_TSA) {
      //do something
    } else {
      return TileScreeningOutcome(
          testData: testData, onUpdateOutcome: onUpdateTest);
    }
  }

  @override
  Widget createSuggestedTileTestOutcome() {
    // TODO: implement createSuggestedTileTestOutcome
    throw UnimplementedError();
  }

  @override
  Widget createOutcomeFormInput(
    BuildContext context,
    ReservableTest test,
  ) {
    if (test.type == TestType.GENERIC_TEST) {
      return GenericOutcomeInputForm();
    } else if (test.type == TestType.BLOOD_TEST ||
        test.type == TestType.CARDIO_TEST ||
        test.type == TestType.ECO_TSA) {
      //do something
    } else {
      return ScreeningOutcomeInputForm(
        reservableTest: test,
        // key: UniqueKey(),
      );
    }
  }
}
