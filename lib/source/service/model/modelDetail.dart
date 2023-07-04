class ModelDetail {
  int? kcal, rasio, subtotal, harga;

  ModelDetail(this.kcal, this.rasio, this.subtotal, this.harga);

  Map toJson() => {'kcal': kcal, 'rasio': rasio, 'subtotal': subtotal, 'harga': harga};

  @override
  String toString() {
    return "{'kcal': $kcal, 'rasio': $rasio, 'subtotal': $subtotal, 'harga': $harga}";
  }
}
