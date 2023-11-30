class Video {
  String? title;
  String? img;
  String? url;
  Video({this.title, this.img, this.url});
  Video.jsondata(Map<String, dynamic> json) {
    title = json['title'];
    img = json['img'];
    url = json['url'];
  }
}
