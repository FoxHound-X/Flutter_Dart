import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(EMoneyApp());
}

class EMoneyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Money Modern',
      theme: ThemeData(
        primaryColor: Color(0xFF6C63FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primaryColor: Color(0xFF6C63FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  double _balance = 2500000;
  AnimationController? _animationController;
  Animation<double>? _animation;

  List<TransactionModel> _recentTransactions = [
    TransactionModel(
      "Netflix",
      "Subscription",
      -149000,
      DateTime.now().subtract(Duration(hours: 2)),
    ),
    TransactionModel(
      "Adi Nugraha",
      "Transfer",
      500000,
      DateTime.now().subtract(Duration(hours: 5)),
    ),
    TransactionModel(
      "Spotify",
      "Subscription",
      -59000,
      DateTime.now().subtract(Duration(days: 1)),
    ),
    TransactionModel(
      "Gojek",
      "Transport",
      -35000,
      DateTime.now().subtract(Duration(days: 1)),
    ),
    TransactionModel(
      "ATM Withdrawal",
      "Withdraw",
      -1000000,
      DateTime.now().subtract(Duration(days: 2)),
    ),
    TransactionModel(
      "Salary",
      "Income",
      5000000,
      DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  List<Map<String, dynamic>> _cards = [
    {
      "number": "**** **** **** 3456",
      "balance": 2500000,
      "expiry": "09/28",
      "color": Color(0xFF6C63FF),
    },
    {
      "number": "**** **** **** 7890",
      "balance": 1200000,
      "expiry": "12/27",
      "color": Color(0xFF00BFA6),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _animationController!.forward();

    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang,",
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          "Budi Santoso",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Cards
              SizedBox(height: 20),
              Container(
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _cards.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (_pageController.position.haveDimensions) {
                          value = _pageController.page! - index;
                          value = (1 - (value.abs() * 0.3)).clamp(0.8, 1.0);
                        }
                        return Transform.scale(scale: value, child: child);
                      },
                      child: _buildCard(index),
                    );
                  },
                ),
              ),

              // Card Indicators
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _cards.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 20 : 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                  context,
                                ).colorScheme.onBackground.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),

              // Quick Actions
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Aksi Cepat",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 100,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    _buildActionButton(
                      context,
                      Icons.send_rounded,
                      "Transfer",
                      Colors.blue,
                    ),
                    _buildActionButton(
                      context,
                      Icons.qr_code_scanner,
                      "Scan QR",
                      Colors.purple,
                    ),
                    _buildActionButton(
                      context,
                      Icons.receipt_long,
                      "Tagihan",
                      Colors.orange,
                    ),
                    _buildActionButton(
                      context,
                      Icons.add_card,
                      "Top Up",
                      Colors.green,
                    ),
                    _buildActionButton(
                      context,
                      Icons.history,
                      "Riwayat",
                      Colors.red,
                    ),
                  ],
                ),
              ),

              // Recent Transactions
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transaksi Terakhir",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _recentTransactions.length,
                itemBuilder: (context, index) {
                  return _buildTransactionItem(_recentTransactions[index]);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onBackground.withOpacity(0.6),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Statistik",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget _buildCard(int index) {
    var card = _cards[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [card["color"], card["color"].withOpacity(0.8)],
          ),
          boxShadow: [
            BoxShadow(
              color: card["color"].withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background design elements
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -20,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
            ),

            // Card content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "E-Money Card",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.contactless_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Rp ${_formatCurrency(card["balance"])}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card["number"],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        "EXP: ${card["expiry"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 80,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(TransactionModel transaction) {
    IconData iconData;
    Color iconColor;

    // Set icon and color based on transaction type
    if (transaction.type == "Subscription") {
      iconData = Icons.subscriptions;
      iconColor = Colors.purple;
    } else if (transaction.type == "Transfer") {
      iconData = Icons.swap_horiz;
      iconColor = Colors.blue;
    } else if (transaction.type == "Withdraw") {
      iconData = Icons.money_off;
      iconColor = Colors.red;
    } else if (transaction.type == "Income") {
      iconData = Icons.paid;
      iconColor = Colors.green;
    } else if (transaction.type == "Transport") {
      iconData = Icons.directions_car;
      iconColor = Colors.amber;
    } else {
      iconData = Icons.attach_money;
      iconColor = Colors.grey;
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(iconData, color: iconColor, size: 24),
      ),
      title: Text(
        transaction.name,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
      subtitle: Text(
        "${transaction.type} • ${_getTimeAgo(transaction.date)}",
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
        ),
      ),
      trailing: Text(
        transaction.amount < 0
            ? "- Rp ${_formatCurrency(transaction.amount.abs())}"
            : "+ Rp ${_formatCurrency(transaction.amount)}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: transaction.amount < 0 ? Colors.red : Colors.green,
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    // Simple formatting for thousand separators
    String amountStr = amount.round().toString();
    String result = '';

    for (int i = 0; i < amountStr.length; i++) {
      if ((amountStr.length - i) % 3 == 0 && i > 0) {
        result += '.';
      }
      result += amountStr[i];
    }

    return result;
  }

  String _getTimeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return "${difference.inDays} hari lalu";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} jam lalu";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} menit lalu";
    } else {
      return "Baru saja";
    }
  }
}

class TransactionModel {
  final String name;
  final String type;
  final double amount;
  final DateTime date;

  TransactionModel(this.name, this.type, this.amount, this.date);
}
