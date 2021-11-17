import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple GST Calculator App',
    home: GSTForm(),
    theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Colors.cyanAccent),
  ));
}

class GSTForm extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _GSTFormState();
  }
}

class _GSTFormState extends State<GSTForm>
{
  var _formKey = GlobalKey<FormState>();


  final _minimumPadding = 5.0;

   var _currentItemSelected = 'interstate';

  TextEditingController amountController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  var displayResult = '';
  var displayResult1 = '';

  @override
  Widget build(BuildContext context)
  {

    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
        appBar: AppBar(
        title: Text('GST Calculator'),
    ),
    body: Form(
    key: _formKey,
    child: Padding(
    padding: EdgeInsets.all(_minimumPadding * 2),
    child: ListView(
    children: <Widget>[
    Padding(
    padding: EdgeInsets.only(
    top: _minimumPadding, bottom: _minimumPadding),
    child: TextFormField(
    keyboardType: TextInputType.number,
    style: textStyle,
    controller: amountController,
    validator: (String value)
    {
    if (value.isEmpty)
    {
    return 'Enter The Amount';
    }
    },
    decoration: InputDecoration(
    labelText: 'Amount',
  hintText: 'Enter Amount',
  labelStyle: textStyle,
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(4.0))),
  )),
  Padding(
  padding: EdgeInsets.only(
  top: _minimumPadding, bottom: _minimumPadding),
  child: TextFormField(
  keyboardType: TextInputType.number,
  style: textStyle,
  controller: discountController,
  validator: (String value)
  {
  if (value.isEmpty)
  {
  return 'Enter Discount Percenage ';
  }
  },
  decoration: InputDecoration(
  labelText: 'Discount(%)',
  hintText: 'Enter Discount',
  labelStyle: textStyle,
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(4.0))),
  )),
  Padding(
  padding: EdgeInsets.only(
  top: _minimumPadding, bottom: _minimumPadding),
  child: TextField(
  keyboardType: TextInputType.number,
  style: textStyle,
  controller: gstController,
  decoration: InputDecoration(
  labelText: 'GST (%)',
  hintText: 'Enter GST percentage',
  labelStyle: textStyle,
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(4.0))),
  )),

      Padding(
          padding: EdgeInsets.only(
              bottom: _minimumPadding,
              top: _minimumPadding,
              left: _minimumPadding * 20,
              right: _minimumPadding * 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColorDark,
                  child: Text(
                    'Calculate',
                    style: textStyle,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState.validate()) {
                        this.displayResult = _calculateTotal(
                            _currentItemSelected);
                      }
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
          style: textStyle,
        ),
      )
    ],
    )),
    ),
    );
  }


  String _calculateTotal(_currentItemSelected) {
    double amount = double.parse(amountController.text);
    double gst = double.parse(gstController.text);
    double discount = double.parse(discountController.text);
    double discountcal = amount * discount / 100;
    double cgst = amount * 9 / 100;
    double sgst = amount * 9 / 100;
    double totalgst = cgst + sgst;
    double totalamount = amount + totalgst - discountcal;

    String result = "GST \n\n"
        "Discount : $discountcal\n"
        "C.G.S.T :  $cgst\n"
        "S.G.S.T :  $sgst\n"
        "Total G.S.T :  $totalgst\n"
        "Total Amount :  $totalamount\n";
    return result;
  }
}