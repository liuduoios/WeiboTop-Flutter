class Top {
  final String hotWord;
  final int hotWordNum;
  final String url;

  const Top({
    required this.hotWord,
    required this.hotWordNum,
    required this.url,
  });

  factory Top.fromJson(Map<String, dynamic> json) {
    return Top(
      hotWord: json['hot_word'] as String,
      hotWordNum: json['hot_word_num'] as int,
      url: json['url'] as String,
    );
  }
}
