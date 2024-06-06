import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/product_repo.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductBloc() : super(ProductLoadingState()) {
    on<ProductEvent>((event, emit) async {
      if (event is SearchProductEvent) {
        emit(ProductLoadingState());
        try {
          final products = await ProductRepository().getProductsByClient(id: event.id
          );
          emit(ProductLoadedState(products));
        } catch (e) {
          emit(ProductErrorState(e.toString()));
        }
      }
    });


  }
}
