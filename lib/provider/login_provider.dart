import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizzy/api_caller/app_url.dart';
import 'dart:async';
import 'package:quizzy/models/user_model.dart';
import 'package:quizzy/models/jwt_token_util.dart';

class AuthProvider extends ChangeNotifier {
  UserDetails? _userDetails;
  UserDetails? get userDetails => _userDetails;
  bool _isAuthenticated = false;
  bool _isRegistered = false;
  String _errorMessage = '';
  String _userId = '';
  String get userId => _userId;
  String get errorMessage => _errorMessage;
  bool _isLoading = false;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  bool get isRegistered => _isRegistered;

  setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginProvider(String email, String password) async {
    try {
      final url = Uri.parse('${AppUrl.baseUrl}/auth/login');
      setLoading(true);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        notifyListeners();
        final decryptedData =
            JwtTokenUtil.decryptJwtToken(jsonResponse['token']);
        setLoading(false);
        setAuthenticated(true);
        _errorMessage = '';
      } else {
        setAuthenticated(false);
        _errorMessage = 'Invalid mobile number or password';
        Timer(const Duration(seconds: 3), () {
          _errorMessage = '';
          notifyListeners();
        });
      }
      notifyListeners();
    } catch (e) {
      setLoading(false);
    } finally {
      setLoading(false);
    }
  }

  Future<void> register(String firstName, String lastName, String email,
      String mobileNo, String password) async {
    try {
      final url = Uri.parse('${AppUrl.baseUrl}/auth/signup');
      setLoading(true);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'mobileNumber': mobileNo,
            'password': password,
          },
        ),
      );
      if (response.statusCode == 200) {
        setLoading(false);
        _isRegistered = true;
        _errorMessage = '';
        notifyListeners();
      } else {
        setLoading(false);
        _errorMessage = 'Internal Server Error';
        Timer(const Duration(seconds: 3), () {
          _errorMessage = '';
          notifyListeners();
        });
      }
      notifyListeners();
    } catch (e) {
      setLoading(false);
    }
  }

  void logout() {
    _errorMessage = '';
    _userId = '';
    setAuthenticated(false);
    notifyListeners();
  }
}