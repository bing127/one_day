import 'dart:convert' show json;

class DateModel {

  List<Data> data;

  DateModel({
    this.data,
  });

  factory DateModel.fromJson(jsonRes){ if(jsonRes == null) return null;


  List<Data> data = jsonRes['data'] is List ? []: null;
  if(data!=null) {
    for (var item in jsonRes['data']) { if (item != null) { data.add(Data.fromJson(item));  }
    }
  }
  return DateModel(
    data:data,);}

  Map<String, dynamic> toJson() => {
    'data': data,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class Data {

  String title;
  String thumbnail;
  String tag;
  String date;
  bool isBig;

  Data({
    this.title,
    this.thumbnail,
    this.tag,
    this.date,
    this.isBig,
  });

  factory Data.fromJson(jsonRes)=>jsonRes == null? null:Data(
    title : jsonRes['title'],
    thumbnail : jsonRes['thumbnail'],
    tag : jsonRes['tag'],
    date : jsonRes['date'],
    isBig : jsonRes['isBig'],);

  Map<String, dynamic> toJson() => {
    'title': title,
    'thumbnail': thumbnail,
    'tag': tag,
    'date': date,
    'isBig': isBig,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}