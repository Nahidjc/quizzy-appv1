import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizzy/api_caller/app_url.dart';
import 'dart:async';
import 'package:quizzy/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
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
  String _name = '';
  String get name => _name;
  int _coin = 0;
  int get coin => _coin;

  setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginProvider(String email, String password) async {
    final url = Uri.parse('${AppUrl.baseUrl}/auth/login');
    setLoading(true);
    try {
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
        UserDetails userDetails = UserDetails.fromJson(jsonResponse['data']);
        _name = userDetails.name;
        _coin = userDetails.coin;
        _userId = userDetails.id;
        notifyListeners();
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

  Future<void> userDetails(String userid) async {
    final url = Uri.parse('${AppUrl.baseUrl}/user/details');
    setLoading(true);
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'userid': userid},
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        UserData userData = UserData.fromJson(jsonResponse);
        _coin = userData.coin;
      }
    } catch (e) {
      _errorMessage = 'An error occurred.';
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void updateTask(data) {
    _coin = data;
    notifyListeners();
  }

  void logout() {
    _errorMessage = '';
    _userId = '';
    _name = '';
    _coin = 0;
    setAuthenticated(false);
    notifyListeners();
  }
}
