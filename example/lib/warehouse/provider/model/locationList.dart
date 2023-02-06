class LocationListModel {
  int count;
  String next;
  Null previous;
  List<ResultsLocation> results;

  LocationListModel({this.count, this.next, this.previous, this.results});

  LocationListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<ResultsLocation>();
      json['results'].forEach((v) {
        results.add(new ResultsLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsLocation {
  int id;
  String name;
  String prefix;
  String code;
  int parent;
  int level;

  ResultsLocation(
      {this.id, this.name, this.prefix, this.code, this.parent, this.level});

  ResultsLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    prefix = json['prefix'];
    code = json['code'];
    parent = json['parent'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['prefix'] = this.prefix;
    data['code'] = this.code;
    data['parent'] = this.parent;
    data['level'] = this.level;
    return data;
  }
}