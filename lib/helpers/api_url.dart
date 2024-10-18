class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id'; // ip responsi
  static const String baseUrlBuku = baseUrl + '/api/buku';
  static const String registrasi = baseUrl + '/api/registrasi';
  static const String login = baseUrl + '/api/login';
  static const String listBuku = baseUrlBuku + '/jumlah_halaman';
  static const String create = baseUrlBuku + '/jumlah_halaman';
  static String update(int id) {
    return baseUrlBuku + '/jumlah_halaman/' + id.toString() + '/update';
  }

  static String show(int id) {
    return baseUrlBuku + '/jumlah_halaman/' + id.toString();
  }

  static String delete(int id) {
    return baseUrlBuku + '/jumlah_halaman/' + id.toString() + '/delete';
  }
}
