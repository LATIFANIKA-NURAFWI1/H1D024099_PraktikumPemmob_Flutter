class Queue<T> {
  final List<T> _items = <T>[];

  // Method untuk menambahkan antrean
  void enqueue(T item) {
    _items.add(item);
    print('Enqueue Paslon: $item');
  }

  // Method untuk mengeluarkan antrean (FIFO)
  T pop() {
    if (_items.isEmpty) {
      throw StateError('Kursi Kosong');
    }
    T item = _items.removeAt(0);
    print('Pop: $item');
    return item;
  }

  // Method untuk menampilkan isi antrean saat ini
  void printQueue() {
    print('Isi Queue paslon saat ini: $_items');
  }

  // Getter untuk mengecek apakah antrean kosong.
  bool get isEmpty => _items.isEmpty;
}

void main() {
  Queue<String> antrean = Queue<String>();

  // 1. Proses Enqueue (Memasukkan data)
  antrean.enqueue('01');
  antrean.enqueue('02');
  antrean.enqueue('03');

  // 2. Menampilkan isi antrean
  antrean.printQueue();

  // 3. Proses Pop (Mengeluarkan data pertama)
  antrean.pop();
  antrean.printQueue();

  // 4. Proses Pop kedua
  antrean.pop();
  antrean.printQueue();

  // 5. Proses Pop ketiga (Sampai Kosong)
  antrean.pop();
  antrean.printQueue();
}