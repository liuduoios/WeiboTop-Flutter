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
        hotWord: json['hot_word'],
        hotWordNum: json['hot_word_num'],
        url: json['url']);
  }
}
