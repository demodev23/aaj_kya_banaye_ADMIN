class UserModel {
  String? id;
  String? phone;
  String? uid;
  String? dateOfBirth;
  List<String>? interest;
  String? name;
  String? address;

  UserModel(
      {this.id,
      this.phone,
      this.uid,
      this.dateOfBirth,
      this.interest,
      this.name,
      this.address});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    uid = json['uid'];
    dateOfBirth = json['date_of_birth'];
    interest = json["interest"] == null ? [] : List<String>.from(json["interest"]!.map((x) => x));
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['uid'] = this.uid;
    data['date_of_birth'] = this.dateOfBirth;
    data['interest'] = this.interest;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}
