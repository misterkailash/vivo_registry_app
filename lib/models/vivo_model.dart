class VivoModel {
  final int? id;
  final String name;
  final BigInt cid;
  final BigInt phone;
  // ignore: non_constant_identifier_names
  final String cust_address;
  final String model;
  // ignore: non_constant_identifier_names
  final BigInt imei_no;
  final BigInt price;
  // ignore: non_constant_identifier_names
  final String purchase_date;
  // ignore: non_constant_identifier_names
  final String entered_by;

  VivoModel(
      {this.id,
      required this.name,
      required this.cid,
      required this.phone,
      // ignore: non_constant_identifier_names
      required this.cust_address,
      required this.model,
      // ignore: non_constant_identifier_names
      required this.imei_no,
      required this.price,
      // ignore: non_constant_identifier_names
      required this.purchase_date,
      // ignore: non_constant_identifier_names
      required this.entered_by});
}
