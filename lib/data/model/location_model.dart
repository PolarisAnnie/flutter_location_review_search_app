// {
//   "title": "<b>서교동</b>주민센터",
//   "link": "",
//   "category": "공공,사회기관>행정복지센터",
//   "description": "",
//   "telephone": "",
//   "address": "서울특별시 마포구 서교동 478-5 주민자치회",
//   "roadAddress": "서울특별시 마포구 동교로15길 7 서교동주민자치회",
//   "mapx": "1269146625",
//   "mapy": "375551473"
// },

class Location {
  final String title;
  final String link;
  final String category;
  final String description;
  final String telephone;
  final String address;
  final String roadAddress;
  final String mapx;
  final String mapy;

  Location({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  Location.fromJson(Map<String, dynamic> map)
    : this(
        title: map['title'],
        link: map['link'],
        category: map['category'],
        description: map['description'],
        telephone: map['telephone'],
        address: map['address'],
        roadAddress: map['roadAddress'],
        mapx: map['mapx'],
        mapy: map['mapy'],
      );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "category": category,
    "description": description,
    "telephone": telephone,
    "address": address,
    "roadAddress": roadAddress,
    "mapx": mapx,
    "mapy": mapy,
  };
}
