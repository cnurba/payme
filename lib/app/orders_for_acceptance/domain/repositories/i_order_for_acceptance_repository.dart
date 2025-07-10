import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc_history.dart';
import 'package:payme/app/orders_for_acceptance/domain/models/order_for_acceptance.dart';

abstract class IOrderForAcceptanceRepository {
  /// Fetches a list of units.
  Future<List<OrderForAcceptance>> getAllForAcceptance();

  Future<bool> createAcceptance(OrderForAcceptance order);
}
