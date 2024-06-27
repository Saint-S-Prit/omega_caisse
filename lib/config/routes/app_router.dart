import 'package:flutter/material.dart';
import 'package:omega_caisse/feactures/seller/presentation/screens/orange_transactor.dart';
import 'package:omega_caisse/feactures/seller/presentation/screens/wave_transactor.dart';
import '../../core/common/animated_splashScreen.dart';
import '../../core/common/onboardingContents/onboarding_screen.dart';
import '../../core/common/onboardingContents/roles_screens.dart';
import '../../core/common/widgets/profile_screen.dart';
import '../../feactures/Seller/presentation/screens/payment_screen.dart';
import '../../feactures/authentication/presentation/screens/login_screen.dart';
import '../../feactures/products/data/cart_item_model.dart';
import '../../feactures/products/data/product_model.dart';
import '../../feactures/products/presentation/screens/Product_invoice.dart';
import '../../feactures/products/presentation/screens/home_screen.dart';
import '../../feactures/products/presentation/widget/print_param.dart';
import '../../feactures/products/presentation/widget/product_command.dart';
import '../../feactures/products/presentation/widget/product_edite.dart';
import '../../core/common/widgets/change_password.dart';
import '../../feactures/seller/presentation/screens/historique_seller_screen.dart';
import '../../feactures/seller/presentation/screens/wave_web_view_screen.dart';
import '../../feactures/supervisor/presentation/screens/historique_supervisor_screen.dart';
import '../../feactures/supervisor/presentation/screens/supervisor_screen.dart';




class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {


    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        //return MaterialPageRoute(builder: (_) => const PrintPage());
        return MaterialPageRoute(builder: (_) => const AnimatedSplashScreen());




        case '/rolesScreens':
        return MaterialPageRoute(
            builder: (_) => const RolesScreens());

        case '/printParam':
        return MaterialPageRoute(
            builder: (_) => const PrintParam());

      case '/loginScreen':
        return MaterialPageRoute(
            builder: (_) => const LoginScreen());

      case '/onboardingScreen':
        return MaterialPageRoute(
            builder: (_) => const OnboardingScreen());
      case '/waveWebViewScreen':
        if (arguments != null && arguments is Map<String, dynamic>) {
          String url = arguments['url'];
          return MaterialPageRoute(
            builder: (_) => WaveWebViewScreen(url: url,),
          );
        }

      case '/adminScreen':
        return MaterialPageRoute(
            builder: (_) =>  SupervisorScreen());


      case '/homeScreen':
        return MaterialPageRoute(
            builder: (_) => const HomeScreen());


        case '/profileScreen':
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen());

        case '/historiesSellerScreen':
          if (arguments != null && arguments is Map<String, dynamic>) {
            int id = arguments['id'];
            String token = arguments['token'];
            return MaterialPageRoute(
              builder: (_) => HistoriesSellerScreen(idSeller: id, token: token,),
            );
          }

          case '/historiesSupervisorScreen':
          if (arguments != null && arguments is Map<String, dynamic>) {
            int id = arguments['id'];
            String token = arguments['token'];
            String? startDay = arguments['startDay'];
            String? endDay = arguments['endDay'];
            return MaterialPageRoute(
              builder: (_) => HistoriesSupervisorScreen(idSeller: id, token: token,startDay: startDay, endDay: endDay),
            );
          }

        case '/paymentScreen':
        return MaterialPageRoute(
            builder: (_) => const PaymentScreen());

      case '/orangeTransactor':
        return MaterialPageRoute(
            builder: (_) => const OrangeTransactor());


      case '/waveTransactor':
        return MaterialPageRoute(
            builder: (_) => const WaveTransactor());

      case '/changePasswordScreen':
        return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen());

        case '/productCommand':
        return MaterialPageRoute(
            builder: (_) => const ProductCommand());

        // case '/productInvoice':
        // return MaterialPageRoute(
        //     builder: (_) => const ProductInvoice());
        case '/productInvoice':
          return MaterialPageRoute(
            builder: (_) => const ProductInvoice(),
          );

      case '/productEdite':
        if (arguments != null && arguments is Map<String, dynamic>) {
          ProductModel productModel = arguments['product'];
          return MaterialPageRoute(
            builder: (_) => ProductEdite(product: productModel),
          );
        }

      default:
        return null;
    }
  }
}


