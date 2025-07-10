import 'package:payme/core/http/server_address.dart';

final String _baseUrl = ServerAddress().baseUrl;

/// Defines endpoints for authentication.
class _Auth {
  String get login => "$_baseUrl/amanat/hs/mobile/auth/GetToken";

  String get refresh => "$_baseUrl/auth/refresh-token";

  String get currentUser => "$_baseUrl/amanat/hs/mobile/user";
}

class _Clients {
  String get clients => "$_baseUrl/amanat/hs/mobile/clients";
}

class _Brand {
  String get brands => "$_baseUrl/amanat/hs/mobile/brands";
}

class _Task {
  String get myTasks => "$_baseUrl/amanat/hs/mobile/task";
}

class _Product {
  String get products => "$_baseUrl/amanat/hs/mobile/products";
}

class _Unit {
  String get units => "$_baseUrl/amanat/hs/mobile/units";
}

class _Floor {
  String get floors => "$_baseUrl/amanat/hs/mobile/floors";
}

class _Object {
  String get objects => "$_baseUrl/amanat/hs/mobile/objects";
}

class _Orders {
  String get orders => "$_baseUrl/amanat/hs/mobile/orders";

  String get acceptance => "$_baseUrl/amanat/hs/mobile/ordersForAcceptance";

  String get supplier => "$_baseUrl/amanat/hs/mobile/orderToSupplier";
}

/// Defines endpoints for connection to server.
class Endpoints {
  static get client => _Clients();

  static get auth => _Auth();

  static get brand => _Brand();

  static get unit => _Unit();

  static get product => _Product();

  static get image => "$_baseUrl/Photos/";

  static get task => _Task();

  static get floor => _Floor();

  static get object => _Object();

  static get order => _Orders();
}
