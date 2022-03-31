import 'package:json_annotation/json_annotation.dart';

part '../mapping/wallet.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Wallet{
  Wallet();
  int _acorns;

  //getter
  int get acorns => _acorns;

  //setter
  set acorns(acorns) => _acorns = acorns;


  factory Wallet.fromJson(Map<dynamic, dynamic> json) => _$WalletFromJson(json);
  Map<dynamic, dynamic> toJson() => _$WalletToJson(this);
}