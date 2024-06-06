import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable{

  final int? id;
  final String? name;
  final List? iconProfession;

  const ProductEntity({
    this.id,
    this.name,
    this.iconProfession
  });

  @override
  List<Object?> get props => [id,name,iconProfession];
}