final String tableUser = 'users';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, name, correo, contra
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String correo = 'correo';
  static final String contra = 'contra';
}

class User {
  final int? id;
  final String name;
  final String correo;
  final String contra;

  const User({
    this.id,
    required this.name,
    required this.correo,
    required this.contra,
  });

  User copy({
    int? id,
    String? name,
    String? correo,
    String? contra,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        correo: correo ?? this.correo,
        contra: contra ?? this.contra,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        name: json[UserFields.name] as String,
        correo: json[UserFields.correo] as String,
        contra: json[UserFields.contra] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.correo: correo,
        UserFields.contra: contra,
      };
}
