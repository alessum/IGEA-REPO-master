import 'package:igea_app/models/gamification/gamification_data.dart';
import 'package:igea_app/models/gamification/wallet.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:igea_app/models/registry.dart';

part 'mapping/user.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class PrevengoUser {
  PrevengoUser();

  RegistryData _registryData;
  GamificationData _gamificationData;
  Wallet _wallet;
  bool _firstAccess;

  //getter
  bool get firstAccess => _firstAccess;
  GamificationData get gamificationData => _gamificationData;
  RegistryData get registryData => _registryData;
  Wallet get wallet => _wallet;

  //setter
  set firstAccess(firstAccess) => _firstAccess = firstAccess;
  set gamificationData(gamificationData) =>
      _gamificationData = gamificationData;
  set registryData(registryData) => _registryData = registryData;
  set wallet(wallet) => _wallet = wallet;

  factory PrevengoUser.fromJson(Map<dynamic, dynamic> json) =>
      _$UserFromJson(json);
  Map<dynamic, dynamic> toJson() => _$UserToJson(this);
}
