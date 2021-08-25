import 'package:flutter/material.dart';
import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({ Key? key }) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController txtHeight = new TextEditingController();
  final TextEditingController txtWeight = new TextEditingController();
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  double? height;
  double? weight;
  late List<bool> isSelected;
  String heightMessage = '';
  String weightMessage = '';

  @override
  void initState() {
    isSelected = [isMetric, !isMetric];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage = 'Input height ' + (isMetric ? 'meters' : 'inches');
    weightMessage = 'Input weight ' + (isMetric ? 'meters' : 'inches');
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      bottomNavigationBar: MenuBottom(),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children:[
            ToggleButtons(
              isSelected: isSelected,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Metric', style: TextStyle(fontSize: fontSize),)
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Imperial', style: TextStyle(fontSize: fontSize),)
                ),
              ],
              onPressed: toggleMeasure,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: txtHeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: heightMessage,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                controller: txtWeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: weightMessage,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: findBMI,
              child: Text('Calculate BMI',
                style: TextStyle(
                  fontSize: fontSize,
                ),
              )
            ),
            Text(result, style: TextStyle(fontSize: fontSize),)
          ],
          
        ),
      ),
    );
  }

  void toggleMeasure(value) {
    isMetric = (value == 0) ? true : false;
    setState(() {
      isSelected = [isMetric, !isMetric];
    });
  }

  void findBMI() {
    double bmi = 0;
    double height = double.tryParse(txtHeight.text) ?? 0;
    double weight = double.tryParse(txtWeight.text) ?? 0;

    if (isMetric) {
      bmi = weight / (height * height);
    } else {
      bmi = weight * 703 / (height * height);
    }
    setState(() {
      result = 'Your BMI is ' + bmi.toStringAsFixed(2);
    });
  }
 }