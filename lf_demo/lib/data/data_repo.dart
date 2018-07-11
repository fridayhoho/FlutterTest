import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

const _API_PATH = "https://exchangeratesapi.io/api/latest";
const HTTP_HEADERS = const {
  'User-Agent': 'Flutter Code Tutorial (http://cogitas.net)',
  'Accept': 'application/json',
};
final DataRepository dataRepository = new DataRepository._private();

class DataRepository {
  DataRepository._private();

  ExchangeRates _exchangeRates;

  Future init() async {
    try {
      _exchangeRates = null;
      final response = await http.get(_API_PATH, headers: HTTP_HEADERS);
      if (response.statusCode == 200) {
        final Map responseJson = json.decode(response.body);
        if (responseJson.containsKey("rates") &&
            responseJson.containsKey("date")) {
          Map rates = responseJson["rates"];
          if (rates.containsKey("USD") && rates.containsKey("GBP")) {
            _exchangeRates = new ExchangeRates(
                responseJson["date"],
                new ExchangeRate("USD", rates["USD"]),
                new ExchangeRate("GBP", rates["GBP"]));
          }
        }
      }
    } catch (e) {}

    // Notify all listeners
    _ready = true;
    for (var listener in _listeners) {
      listener.complete(_exchangeRates);
    }
    _listeners = new List<Completer<ExchangeRates>>();
  }

  bool _ready = false;

  List<Completer<ExchangeRates>> _listeners = new List<Completer<ExchangeRates>>();

  Future<ExchangeRates> getExchangeRates() async {
    if (_ready) {
      return _exchangeRates;
    } else {
      Completer<ExchangeRates> listener = new Completer<ExchangeRates>();
      _listeners.add(listener);
      return listener.future;
    }
  }
}

class ExchangeRates {
  final String dateStr;
  final ExchangeRate rateUSD;
  final ExchangeRate rateGBP;
  const ExchangeRates(this.dateStr, this.rateUSD, this.rateGBP);
}

class ExchangeRate {
  final String currencyDisplay;
  final double rate;
  const ExchangeRate(this.currencyDisplay, this.rate);
}
