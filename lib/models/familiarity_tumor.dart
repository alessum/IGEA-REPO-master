import 'package:igea_app/models/enums/parent_type.dart';
import 'package:igea_app/models/enums/tumor_type.dart';
import 'package:json_annotation/json_annotation.dart';


part 'mapping/familiarity_tumor.g.dart';

class FamiliarityTumor{

  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  FamiliarityTumor(ParentType parentType, TumorType tumorType, String label, int tumorCount);

  ParentType _parentType;
  TumorType _tumorType;
  String _label;
  int _tumorCount;

  ParentType get parentType => _parentType;
  TumorType get tumorType => _tumorType;
  String get label => _label;
  int get tumorCount => _tumorCount;



  set parentType(parentType) => _parentType = parentType;
  set tumorType(tumorType) => _tumorType = tumorType;
  set tumorCount(tumorCount) => _tumorCount = tumorCount;
  set label(label) => _label = label;
  
  factory FamiliarityTumor.fromJson(Map<dynamic, dynamic> json) => _$FamiliarityTumorFromJson(json);
  Map<dynamic,dynamic> toJson() => _$FamiliarityTumorToJson(this);


}