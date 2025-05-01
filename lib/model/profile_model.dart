import 'package:hive/hive.dart';

part 'profile_model.g.dart';
// flutter packages pub run build_runner build
@HiveType(typeId: 1)
class Profile {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String imagePath;

  @HiveField(5)
  final String bio;

  Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imagePath,
    required this.bio,
  });

  Profile copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? imagePath,
    String? bio,
  }) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      imagePath: imagePath ?? this.imagePath,
      bio: bio ?? this.bio,
    );
  }
}
