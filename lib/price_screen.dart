import 'dart:html';

import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_app/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker_app/service/ticker.dart';
import 'dart:io' show Platform;
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getTicker();
  }

  String selectedCurrency = 'USD';
  String? exchangeValue = '';
  bool isWaiting = false;
  Map<String,String> coinValue = {};
  Future getTicker() async{
    isWaiting = true;
    TickerModel tickerModel = TickerModel();

    var currencyData = await tickerModel.convertCurrency(selectedCurrency);
    isWaiting = false;
    setState(() {
      coinValue = currencyData;
    });


  }
   DropdownButton<dynamic> androidDropDownButton(){
     List<DropdownMenuItem<String>> dropDownmenuItem = [];
     for(var currency in currenciesList){
       var dropdown = DropdownMenuItem(
           child: Text(currency),
           value: currency
       );
       dropDownmenuItem.add(dropdown);
     }
   return  DropdownButton<dynamic> (
      items: dropDownmenuItem,
      value: selectedCurrency,
      onChanged: (value) async{

       setState((){
         selectedCurrency = value;
         getTicker();
          });
          }
       );

  }
  CupertinoPicker iosPicker(){
    List<Text> textItem = [];
    for(var currency in currenciesList){
      var text = Text(currency);
      textItem.add(text);
    }
     return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          selectedCurrency = currenciesList[selectedIndex];

        },
        children: textItem
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

        //3: You'll need to use a Column Widget to contain the three CryptoCards.
        Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(
            cryptoCurrency: 'BTC',
            //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
            value: isWaiting ? '?' : coinValue['BTC'],
            selectedCurrency: selectedCurrency,
          ),
          CryptoCard(
            cryptoCurrency: 'ETH',
            value: isWaiting ? '?' : coinValue['ETH'],
            selectedCurrency: selectedCurrency,
          ),
          CryptoCard(
            cryptoCurrency: 'LTC',
            value: isWaiting ? '?' : coinValue['LTC'],
            selectedCurrency: selectedCurrency,
          ),
        ],
      ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //child:Platform.isIOS ? iosPicker() : androidDropDownButton(),
            child: androidDropDownButton(),
          )
        ],
      ),
    );
  }
}
class CryptoCard extends StatelessWidget{
  CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency
    });
  final String? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;
  Widget build(BuildContext context){
  return Padding(
   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
    child: Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
     child: Padding(
       padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 28.0),
       child: Text(
         '1 $cryptoCurrency = $value  $selectedCurrency',
         textAlign: TextAlign.center,
         style: TextStyle(
           fontSize: 20.0,
           color: Colors.white,
         ),

       ),
     ),
    ),

  );
  }

}
