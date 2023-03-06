class UserData {
  String name;
  String email;
  String profileImage;

  UserData({this.name, this.email, this.profileImage});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    email = json['email'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    return data;
  }
}