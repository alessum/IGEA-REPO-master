import 'package:igea_app/models/outcome.dart';

abstract class OutcomeFactory {
  Outcome createOutcomeFromJson(Map<String,dynamic> json);
}