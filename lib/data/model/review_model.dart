// firebase에서는 맵까지는 자동 변환해서 전달해주고 있음
// {mapX: 123445, id: 1, content: 짱이에요, mapY: 343533, createdAt:2025-07-30T20:40:00.000Z}

class Review {
  final String? id;
  final String content;
  final DateTime createdAt;
  final double mapX;
  final double mapY;

  Review({
    this.id,
    required this.content,
    required this.createdAt,
    required this.mapX,
    required this.mapY,
  });

  // 맵으로 받는 내용을 클래스 객체로 넣어주기만 하면 됨
  Review.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        content: map['content'],
        createdAt: DateTime.parse(map['createdAt']),
        mapX: double.parse(map['mapX']),
        mapY: double.parse(map['mapY']),
      );

  Map<String, dynamic> toJson() => {
    // "id": id, firebase가 자동 생성
    "content": content,
    "createdAt": createdAt.toIso8601String(),
    "mapX": mapX.toString(),
    "mapY": mapY.toString(),
  };
}
