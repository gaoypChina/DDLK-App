import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  @JsonKey(name: 'q')
  String? keyword;
  int? page;
  int? pageSize;
  bool opening;
  String nearby;
  String? price;
  double? lat;
  double? long;
  List<String>? categories;
  List<String>? subCategories;
  String? sort;

  SearchModel({
    this.page,
    this.pageSize,
    this.opening = false,
    this.nearby = '',
    this.price,
    this.lat,
    this.long,
    this.categories,
    this.subCategories,
    this.sort,
  });

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
//  "q": "",
//     "regions": [],
//     "categories": [],
//     "benefits": [],
//     "subCategories": [],
//     "nearby": "6259d043527cc7100a6fa960",
//     "lat": "10.9303009",
//     "long": "107.2448221",
//     "page": 1,
//     "pageSize": 10,
//     "opening": true,
//     "price": "0-500000"