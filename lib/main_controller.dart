import 'package:get/get.dart';

class MainController extends GetxController {
  final RxDouble _totalBill = 0.00.obs;
  final RxDouble _tip = 0.00.obs;
  final RxDouble _individualBill = 0.00.obs;
  final RxInt _totalPersons = 1.obs;

  double get totalBill => _totalBill.value;
  double get tip => _tip.value;
  double get individualBill => _individualBill.value;
  int get totalPersons => _totalPersons.value;

  void setTotalBill(double value) {
    _totalBill.value = value;
    calculateIndividualBill();
  }

  void setTip(double value) {
    _tip.value = value;
    calculateIndividualBill();
  }

  void addPerson() {
    _totalPersons.value++;
    calculateIndividualBill();
  }

  void removePerson() {
    if (_totalPersons.value > 1) {
      _totalPersons.value--;
      calculateIndividualBill();
    }
  }

  RxDouble calculateIndividualBill() {
    _individualBill.value =
        (_totalBill.value + _tip.value) / _totalPersons.value;
    return _individualBill;
  }
}
