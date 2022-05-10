import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  String? keyword;
  int? page;
  int? pageSize;

  SearchModel({
    this.page,
    this.pageSize,
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