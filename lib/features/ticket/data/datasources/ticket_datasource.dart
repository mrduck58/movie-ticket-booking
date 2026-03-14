import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ticket_model.dart';

class TicketDatasource {
  Future<List<TicketModel>> getTickets() async {
    final jsonString =
        await rootBundle.loadString('assets/mock/ticket.json');

    final List data = json.decode(jsonString);

    return data.map((e) => TicketModel.fromJson(e)).toList();
  }
}