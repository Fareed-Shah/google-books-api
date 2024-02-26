class ImageLinks {
  String? thumbnail;

  ImageLinks({this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    var imageLinksParssed = ImageLinks();
    imageLinksParssed.thumbnail = json['thumbnail'];
    return imageLinksParssed;
  }
}
