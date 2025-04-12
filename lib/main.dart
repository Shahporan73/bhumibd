import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'app/routes/app_pages.dart';
import 'package:bhumibd/app/resource/widget/no_internet_widget.dart';

void main() {
  runApp(MainScreen());
}

/// Network check wrapper
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ConnectivityResult? _connectivityResult;
  bool _isConnectedToInternet = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initializeConnectivity();

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
          final hasInternet = result != ConnectivityResult.none;
          if (mounted && _isConnectedToInternet != hasInternet) {
            setState(() {
              _connectivityResult = result;
              _isConnectedToInternet = hasInternet;
            });
          }
        });
  }

  Future<void> _initializeConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    if (mounted) {
      setState(() {
        _connectivityResult = result;
        _isConnectedToInternet = result != ConnectivityResult.none;
      });
    }
  }

  void _retryConnection() async {
    await _initializeConnectivity();
    if (!_isConnectedToInternet && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No internet connection detected. Please check your network settings.',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_connectivityResult == null) {
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    } else if (!_isConnectedToInternet) {
      return MaterialApp(
        home: NoInternetScreen(onRetry: _retryConnection),
      );
    }

    // Show actual app when connected
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
