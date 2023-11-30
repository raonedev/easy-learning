class Qmodel {
  String? q;
  String? a;
  Qmodel({this.q, this.a});
  Qmodel.jsondata(Map<String, dynamic> json) {
    q = json['quote'];
    a = json['author'];
  }
}
