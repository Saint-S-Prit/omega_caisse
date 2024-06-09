import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_themes.dart';
import 'core/services/storage/SharedPreferencesService.dart';
import 'core/services/theme/theme_bloc.dart';
import 'core/services/toggle_obscure_text/toggle_obscure_text_bloc.dart';
import 'core/utils/constants/app_constants.dart';
import 'feactures/authentication/presentation/bloc/handle_password/handle_password_bloc.dart';
import 'feactures/authentication/presentation/bloc/login/login_bloc.dart';
import 'feactures/authentication/presentation/bloc/logout/logout_bloc.dart';
import 'feactures/authentication/presentation/bloc/register/register_bloc.dart';
import 'feactures/products/presentation/bloc/cart/add_to_cart_bloc.dart';
import 'feactures/products/presentation/bloc/product/product_bloc.dart';
import 'feactures/products/presentation/bloc/product/update/product_update_bloc.dart';
import 'feactures/products/presentation/bloc/solde/product_bloc.dart';
import 'feactures/seller/presentation/bloc/history/history_bloc.dart';
import 'feactures/seller/presentation/bloc/order/order_bloc.dart';
import 'feactures/seller/presentation/bloc/payment/payment_bloc.dart';
import 'feactures/supervisor/presentation/bloc/supervisor_bloc.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  await GetStorage.init();

  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (BuildContext context) => ThemeBloc(),),
        BlocProvider<ToggleObscureTextBloc>(create: (BuildContext context) => ToggleObscureTextBloc(),),
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<LogoutBloc>(create: (BuildContext context) => LogoutBloc()),
        BlocProvider<ProductBloc>(create: (BuildContext context) => ProductBloc(),),
        BlocProvider<ProductUpdateBloc>(create: (BuildContext context) => ProductUpdateBloc(),),
        BlocProvider<RegisterBloc>(create: (BuildContext context) => RegisterBloc()),
        BlocProvider<CartBloc>(create: (BuildContext context) => CartBloc()),
        BlocProvider<SoldBloc>(create: (BuildContext context) => SoldBloc()),
        BlocProvider<HistoryBloc>(create: (BuildContext context) => HistoryBloc()),
        BlocProvider<OrderBloc>(create: (BuildContext context) => OrderBloc()),
        BlocProvider<SupervisorBloc>(create: (BuildContext context) => SupervisorBloc()),
        BlocProvider<HandlePasswordBloc>(create: (BuildContext context) => HandlePasswordBloc()),
        BlocProvider<PaymentBloc>(create: (BuildContext context) => PaymentBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            title: applicationName,
            theme: lightTheme,
            themeMode: state,
            darkTheme: darkTheme,
            initialRoute: '/',
            onGenerateRoute: AppRouter().onGenerateRoute,

          );
        },
      ),
    );
  }
}


