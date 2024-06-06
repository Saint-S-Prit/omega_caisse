import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repository/product_repo.dart';
import 'product_update_event.dart';
import 'product_update_state.dart';


  class ProductUpdateBloc extends Bloc<ProductUpdateEvent, UpdateProductState> {

    ProductUpdateBloc() : super(UpdateProductInitState()) {

      on<UpdateProdEvent>((event, emit) async {
        if (event is UpdateProdEvent) {
          emit(UpdateProdLoadingState());
          try {
            final products = await ProductRepository().updateProduct(productModel: event.productModel
            );
            emit(UpdateProdLoaderState(products));
          } catch (e) {
            emit(UpdateProdErrorState(e.toString()));
          }
        }
      });

  }
  }
