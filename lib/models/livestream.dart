class LiveStream {
  final String title;
  final String tag;
  final String image;
  final String uid;
  final String username;
  final startedAt;
  final int viewers;
  final String channelId;

  LiveStream({
    required this.title,
    required this.tag,
    required this.image,
    required this.uid,
    required this.username,
    required this.startedAt,
    required this.viewers,
    required this.channelId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tag': tag,
      'image': image,
      'uid': uid,
      'username': username,
      'startedAt': startedAt,
      'viewers': viewers,
      'channelId': channelId,
    };
  }

  factory LiveStream.fromMap(Map<String, dynamic> map) {
    return LiveStream(
      title: map['title'] ?? '',
      tag: map['tag'],
      image: map['image'],
      uid: map['uid'],
      username: map['username'],
      startedAt: map['startedAt'],
      viewers: map['viewers'],
      channelId: map['channelId'],
    );
  }
}
