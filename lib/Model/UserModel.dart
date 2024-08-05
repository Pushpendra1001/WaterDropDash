class UserModel {
  final String uid;
  final String email;
  final String name;
  final int targetWaterIntake;

  UserModel({required this.uid, required this.email, required this.name, required this.targetWaterIntake});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      targetWaterIntake: data['targetWaterIntake'] ?? 0,
    );
  }
}
