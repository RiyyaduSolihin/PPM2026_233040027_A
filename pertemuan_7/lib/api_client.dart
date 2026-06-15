import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'main.dart' show Catatan;

// =====================================================================
// EXCEPTION KUSTOM — ApiException
// =====================================================================
//
// Dilempar ketika server merespons dengan status 4xx/5xx,
// atau ketika tidak ada koneksi / timeout.
// Tujuan: UI cukup catch ApiException dan tampilkan e.message,
// tidak perlu tahu detail teknis HTTP.
class ApiException implements Exception {
  final int statusCode; // 0 = network error (no internet / timeout)
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException($statusCode): $message';
}

// =====================================================================
// API CLIENT — Singleton
// =====================================================================
//
// Pola sama dengan DbHelper di P4: satu instance dipakai di seluruh app.
// Semua operasi HTTP terpusat di sini — UI tidak perlu tahu soal URL,
// header, atau jsonEncode/Decode.
class ApiClient {
  // Private constructor — tidak bisa dibuat dari luar.
  ApiClient._();

  // Satu-satunya instance yang boleh dipakai.
  static final ApiClient instance = ApiClient._();

  // ===== Konfigurasi =====
  static const String _baseUrl =
      'https://besab-production.up.railway.app/api';

  static const String _apiKey =
      '8f38b5fbf0bc437285f2c62ed6e447eab56f78c8f95239a7';

  // Request dibatalkan otomatis jika server tidak merespons dalam 10 detik.
  static const _timeout = Duration(seconds: 10);

  // Header wajib dikirim di setiap request.
  Map<String, String> get _headers => {
    'X-API-Key': _apiKey,
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // =====================================================================
  // CRUD METHODS
  // =====================================================================

  // GET /catatan → ambil semua catatan
  Future<List<Catatan>> getAll() async {
    final res = await _send(
          () => http.get(
        Uri.parse('$_baseUrl/catatan'),
        headers: _headers,
      ),
    );

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (body['data'] as List).cast<Map<String, dynamic>>();
    return list.map(Catatan.fromJson).toList();
  }

  // GET /catatan/{id} → ambil satu catatan berdasarkan id
  Future<Catatan> getById(int id) async {
    final res = await _send(
          () => http.get(
        Uri.parse('$_baseUrl/catatan/$id'),
        headers: _headers,
      ),
    );

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  // POST /catatan → tambah catatan baru, server kembalikan catatan + id
  Future<Catatan> insert(Catatan c) async {
    final res = await _send(
          () => http.post(
        Uri.parse('$_baseUrl/catatan'),
        headers: _headers,
        body: jsonEncode(c.toJson()),
      ),
    );

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  // PUT /catatan/{id} → update catatan yang sudah ada
  Future<Catatan> update(Catatan c) async {
    assert(c.id != null, 'update() dipanggil tapi catatan belum punya id');

    final res = await _send(
          () => http.put(
        Uri.parse('$_baseUrl/catatan/${c.id}'),
        headers: _headers,
        body: jsonEncode(c.toJson()),
      ),
    );

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  // DELETE /catatan/{id} → hapus catatan, tidak kembalikan data
  Future<void> delete(int id) async {
    await _send(
          () => http.delete(
        Uri.parse('$_baseUrl/catatan/$id'),
        headers: _headers,
      ),
    );
  }

  // =====================================================================
  // HELPER PRIVATE
  // =====================================================================

  // _send: eksekusi request + tangani 3 kelas error jaringan.
  //
  // Kelas error:
  //   1. Status 4xx/5xx → throw ApiException dengan pesan dari server
  //   2. SocketException → tidak ada koneksi internet
  //   3. TimeoutException → server tidak merespons dalam _timeout
  Future<http.Response> _send(
      Future<http.Response> Function() request,
      ) async {
    try {
      final res = await request().timeout(_timeout);

      // TAMBAH INI sementara untuk debug
      print('=== STATUS: ${res.statusCode}');
      print('=== BODY: ${res.body}');

      if (res.statusCode >= 200 && res.statusCode < 300) return res;
      throw ApiException(res.statusCode, _pesanDariResponse(res));
    } on SocketException catch (e) {
      print('=== SOCKET ERROR: $e');
      throw ApiException(0, 'Tidak ada koneksi internet.');
    } on TimeoutException catch (e) {
      print('=== TIMEOUT: $e');
      throw ApiException(0, 'Server tidak merespons (timeout).');
    }
  }

  // Coba ambil field 'message' dari body JSON server.
  // Kalau gagal (body bukan JSON), kembalikan "HTTP {statusCode}".
  String _pesanDariResponse(http.Response res) {
    try {
      final map = jsonDecode(res.body) as Map<String, dynamic>;
      return (map['message'] as String?) ?? 'HTTP ${res.statusCode}';
    } catch (_) {
      return 'HTTP ${res.statusCode}';
    }
  }
}
