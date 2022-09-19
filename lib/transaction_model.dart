class TransactionModel {
  final DateTime date;
  final int id;
  final String title;
  final double price;

  TransactionModel(
      {required this.date,
      required this.id,
      required this.title,
      required this.price});
}
