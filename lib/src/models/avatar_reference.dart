class AvatarReference {
  AvatarReference(this.imgUrl);
  final String imgUrl;

  factory AvatarReference.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String imgUrl = data['imgUrl'];
    if (imgUrl == null) {
      return null;
    }
    return AvatarReference(imgUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
    };
  }
}