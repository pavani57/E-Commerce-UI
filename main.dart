import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();

  var _curriences = ['Rupees', 'Dollars', 'Pounds', 'Others'];
  final _minimumPadding = 5.0;

  var _currentItemSelected = 'Rupees';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Simple Interest Calculator',
        style: TextStyle(fontFamily: 'JosefinSans',
          fontSize: 25,
          color: Colors.black,
        ),
      ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            // margin: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalController,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter principal amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          hintText: 'enter principal e.g. 1200',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter rate of interest';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          hintText: 'in percent',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: textStyle,
                              controller: termController,
                              // ignore: missing_return
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter term';
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Term',
                                  hintText: 'Time in years',
                                  labelStyle: textStyle,
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                              items: _curriences.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _currentItemSelected,
                              onChanged: (String newValueSelected) {
                                _onDropDownItemSelected(newValueSelected);
                              },
                            ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                         primary : Colors.lightGreen,
                      ),
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.0,
                              style: TextStyle(fontFamily: 'JosefinSans',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculateTotalReturns();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary  : Colors.grey,
                            ),
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.0,
                              style: TextStyle(fontFamily: 'JosefinSans',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: TextStyle(fontFamily: 'JosefinSans',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 200),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.copyright),
                        Text(
                          " copyright All Rights Reserved.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'JosefinSans',
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                ),

              //  SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                   "Designed by Konisa Pavani",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'JosefinSans',
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),

              ],
            )),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable in $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _curriences[0];
  }




}