const menu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

// OrderItem class
class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  
  double get subtotal => price * qty;
}

// Look up item price
OrderItem orderOf(String name, int qty) {
  final price = menu[name];

  if (price == null) {
    throw ArgumentError('Item not found: $name');
  }

  return OrderItem(name, price, qty);
}

// Calculate total using fold
double total(List<OrderItem> items) {
  return items.fold(0.0, (sum, item) => sum + item.subtotal);
}

// Print receipt
void printReceipt(List<OrderItem> items, {String? customer}) {
  final name = customer ?? 'Guest';
  final subtotal = total(items);

  final discount = subtotal >= 300 ? subtotal * 0.10 : 0.0;
  final finalTotal = subtotal - discount;

  print('\nOrder for $name');

  for (var item in items) {
    print(
      '${item.qty} x ${item.name.padRight(15)}'
      '${item.subtotal.toStringAsFixed(2).padLeft(8)}',
    );
  }

  print('Subtotal'.padRight(24) + subtotal.toStringAsFixed(2).padLeft(8));

  if (discount > 0) {
    print(
      'Discount 10%'.padRight(24) +
          '-${discount.toStringAsFixed(2)}'.padLeft(8),
    );
  }

  print('Total'.padRight(24) + finalTotal.toStringAsFixed(2).padLeft(8));
}

void main() {
  // First order: Guest
  final order1 = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];

  printReceipt(order1);

  // Second order: Named customer below 300
  final order2 = [orderOf('Adobo rice', 1), orderOf('Iced tea', 1)];

  printReceipt(order2, customer: 'Beau');
}
