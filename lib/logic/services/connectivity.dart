import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isInternetConnected() async {
  final connectivityResult  = await Connectivity().checkConnectivity();
  return connectivityResult!=ConnectivityResult.none;
}