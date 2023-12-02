import 'package:edi/bar_graph/individual_graph.dart';

class BarData {
  final double oneamount;
  final double twoamount;
  final double threeamount;
  final double fouramount;
  final double fiveamount;
  final double sixamount;
  final double sevenamount;

  BarData({
    required this.oneamount,
    required this.twoamount,
    required this.threeamount,
    required this.fouramount,
    required this.fiveamount,
    required this.sixamount,
    required this.sevenamount,
  });

  List<IndividualBar> bardata = [];

  void init() {
    bardata = [
      IndividualBar(x: 1, y: oneamount),
      IndividualBar(x: 2, y: twoamount),
      IndividualBar(x: 3, y: threeamount),
      IndividualBar(x: 4, y: fouramount),
      IndividualBar(x: 5, y: fiveamount),
      IndividualBar(x: 6, y: sixamount),
      IndividualBar(x: 7, y: sevenamount),
    ];
  }
}
