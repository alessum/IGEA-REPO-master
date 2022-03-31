part 'mapping/review.g.dart';

class Review {
  Review(this._rating, this._title, this._message, this._username);

  int _rating;
  String _message;
  String _username;
  String _title;

  int get rating => _rating;
  String get message => _message;
  String get username => _username;
  String get title => _title;

  factory Review.fromJson(Map<dynamic, dynamic> json) => _$ReviewFromJson(json);
  Map<dynamic, dynamic> toJson() => _$ReviewToJson(this);
}
