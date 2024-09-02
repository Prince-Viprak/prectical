class ProfileModel {
  final String name, email, mobileNo, date, day;
  int? profileId;

   ProfileModel(
      {required this.email,
      required this.name,
      required this.day,
      required this.date,
      required this.mobileNo,
      this.profileId});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        email: json['email'].toString(),
        name: json['name'].toString(),
        day: json['day'].toString(),
        date: json['date'].toString(),
        mobileNo: json['mobileNo'].toString(),
        profileId: json['id']);
  }

  Map<String, Object?> toJson() => {
        'id': profileId,
        'name': name,
        'email': email,
        'mobileNo': mobileNo,
        'day': day,
        'date': date,
      };
}
