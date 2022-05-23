import 'package:bitcoin_ticker_app/service/networking.dart';
import '../coin_data.dart';
class TickerModel{

  static const apiKey = '8979D83C-FBC9-47AD-994A-069C34626436';
  static const tickerUrl = 'https://rest.coinapi.io/v1/exchangerate/';
  Future convertCurrency(String currency)async{
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList){
      var url = tickerUrl+crypto+'/'+currency+'?apikey='+apiKey;
      NetworkHelper networkHelper = NetworkHelper(url);
      var tickerData = await networkHelper.getData();
       double lastPrice = tickerData['rate'];
       cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);

    }
    return cryptoPrices;

  }
}