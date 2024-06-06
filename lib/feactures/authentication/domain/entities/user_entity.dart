import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  final int? id;
  final String? name;
  final List? iconProfession;

  const UserEntity({
    this.id,
    this.name,
    this.iconProfession
  });

  @override
  List<Object?> get props => [id,name,iconProfession];
}