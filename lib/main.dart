import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const mint = Color(0xFF00F5C8);
const cyan = Color(0xFF42C8FF);
const purple = Color(0xFFB66BFF);
const orange = Color(0xFFFFA24C);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartBarApp());
}

class SmartBarApp extends StatelessWidget {
  const SmartBarApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'SMART BAR',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF070A12),
          colorScheme: ColorScheme.fromSeed(
            seedColor: mint,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      );
}

enum Channel { news, football, markets, clock }

class FeedItem {
  const FeedItem(this.title, this.detail, this.source, {this.positive = true});
  final String title;
  final String detail;
  final String source;
  final bool positive;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Channel channel = Channel.news;
  Color accent = mint;
  double speed = 42;
  double fontSize = 30;

  String get channelName => switch (channel) {
        Channel.news => 'الأخبار',
        Channel.football => 'كرة القدم',
        Channel.markets => 'الأسواق',
        Channel.clock => 'الساعة',
      };

  List<FeedItem> get items => switch (channel) {
        Channel.news => const [
            FeedItem('آخر الأخبار', 'عناوين عربية وعالمية', 'SMART BAR'),
            FeedItem('BBC NEWS', 'نموذج تجريبي — ستضاف الأخبار الحية لاحقاً', 'BBC'),
            FeedItem('الجزيرة', 'محتوى تجريبي', 'ALJAZEERA'),
            FeedItem('REUTERS', 'International headlines preview', 'REUTERS'),
          ],
        Channel.football => const [
            FeedItem('مباريات اليوم', 'بيانات تجريبية وليست نتائج مباشرة', 'FOOTBALL'),
            FeedItem('REAL MADRID  2 - 1  BARÇA', 'DEMO • 78 min', 'LA LIGA'),
            FeedItem('MAN CITY  1 - 0  ARSENAL', 'DEMO • 54 min', 'PREMIER LEAGUE'),
          ],
        Channel.markets => const [
            FeedItem('الأسواق المالية', 'أسعار تجريبية وليست أسعاراً حية', 'MARKETS'),
            FeedItem('BTC / USD', '67,420  +1.8%', 'CRYPTO'),
            FeedItem('S&P 500', '5,820  -0.4%', 'NYSE', positive: false),
            FeedItem('EUR / USD', '1.0842  +0.2%', 'FX'),
          ],
        Channel.clock => const [
            FeedItem('SMART BAR', 'الوقت والتاريخ', 'CLOCK'),
          ],
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [mint, cyan, purple],
                      ),
                    ),
                    child: const Icon(Icons.graphic_eq,
                        color: Colors.black, size: 28),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SMART BAR',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2)),
                        Text('RGB INFORMATION DISPLAY',
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.white54,
                                letterSpacing: 1.5)),
                      ],
                    ),
                  ),
                  const Icon(Icons.settings_suggest, color: mint, size: 27),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF17283A),
                      Color(0xFF111321),
                      Color(0xFF21152F)
                    ],
                  ),
                  border: Border.all(color: mint.withValues(alpha: .3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('YOUR WORLD. ONE DISPLAY.',
                        style: TextStyle(
                            color: mint,
                            fontSize: 10,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    const Text('كل ما يهمك،\nعلى شاشة واحدة.',
                        style: TextStyle(
                            fontSize: 29,
                            height: 1.3,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text('اختر المحتوى وشغّل شاشة العرض.',
                        style: TextStyle(color: Colors.white60)),
                    const SizedBox(height: 18),
                    Container(
                      height: 66,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF020408),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: accent.withValues(alpha: .6)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.wifi_tethering, color: accent),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(items.first.title,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: accent,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: mint,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DisplayPage(
                              channelName: channelName,
                              channel: channel,
                              items: items,
                              accent: accent,
                              speed: speed,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('START FULL SCREEN',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              const Text('CONTENT CHANNELS',
                  style: TextStyle(color: Colors.white38, fontSize: 10,
                      letterSpacing: 2)),
              const SizedBox(height: 6),
              const Text('اختر نوع العرض',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.45,
                children: [
                  _modeCard(Channel.news, Icons.newspaper, mint, 'الأخبار',
                      'مصادر عربية وعالمية'),
                  _modeCard(Channel.football, Icons.sports_soccer, cyan,
                      'كرة القدم', 'المباريات والنتائج'),
                  _modeCard(Channel.markets, Icons.candlestick_chart, orange,
                      'الأسواق', 'الأسهم والعملات'),
                  _modeCard(Channel.clock, Icons.schedule, purple, 'الساعة',
                      'الوقت والتاريخ'),
                ],
              ),
              const SizedBox(height: 24),
              const Text('DISPLAY SETTINGS',
                  style: TextStyle(color: Colors.white38, fontSize: 10,
                      letterSpacing: 2)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF101522),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accent.withValues(alpha: .3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('لون الإضاءة'),
                    const SizedBox(height: 12),
                    Row(
                      children: [mint, cyan, purple, orange, Colors.white]
                          .map((color) => GestureDetector(
                                onTap: () => setState(() => accent = color),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  margin: const EdgeInsets.only(right: 14),
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: accent == color
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 14),
                    Text('سرعة الحركة: ${speed.round()}'),
                    Slider(
                      value: speed,
                      min: 15,
                      max: 100,
                      activeColor: accent,
                      onChanged: (value) => setState(() => speed = value),
                    ),
                    Text('حجم النص: ${fontSize.round()}'),
                    Slider(
                      value: fontSize,
                      min: 20,
                      max: 48,
                      activeColor: accent,
                      onChanged: (value) => setState(() => fontSize = value),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text('SMART BAR • RGB EDITION 0.1.0',
                    style: TextStyle(
                        color: Colors.white30,
                        fontSize: 10,
                        letterSpacing: 1)),
              ),
            ],
          ),
        ),
      );

  Widget _modeCard(Channel value, IconData icon, Color color, String label,
      String hint) {
    final selected = channel == value;
    return InkWell(
      onTap: () => setState(() {
        channel = value;
        accent = color;
      }),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF101522),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: selected ? color : Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 27),
                if (selected) Icon(Icons.check_circle, color: color, size: 18),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 3),
                Text(hint,
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayPage extends StatefulWidget {
  const DisplayPage({
    super.key,
    required this.channelName,
    required this.channel,
    required this.items,
    required this.accent,
    required this.speed,
    required this.fontSize,
  });

  final String channelName;
  final Channel channel;
  final List<FeedItem> items;
  final Color accent;
  final double speed;
  final double fontSize;

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  Timer? clockTimer;
  DateTime now = DateTime.now();
  bool paused = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    controller = AnimationController(
      vsync: this,
      duration: Duration(
          seconds: (180 / (widget.speed / 42)).round().clamp(20, 300)),
    )..repeat();
    clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => now = DateTime.now());
    });
  }

  @override
  void dispose() {
    clockTimer?.cancel();
    controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF020409),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => paused = !paused),
          onLongPress: () => Navigator.pop(context),
          child: Stack(
            children: [
              Positioned.fill(
                  child: CustomPaint(painter: GridPainter(widget.accent))),
              Center(
                child: widget.channel == Channel.clock
                    ? _clock()
                    : _ticker(),
              ),
              Positioned(
                top: 18,
                left: 18,
                right: 18,
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 7, color: widget.accent),
                    const SizedBox(width: 8),
                    Text('SMART BAR  /  ${widget.channelName}',
                        style: TextStyle(
                            color: widget.accent,
                            fontSize: 10,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.fullscreen, color: Colors.white30),
                  ],
                ),
              ),
              Positioned(
                bottom: 18,
                left: 0,
                right: 0,
                child: Text(
                  paused
                      ? 'PAUSED • LONG PRESS TO EXIT'
                      : 'TAP TO PAUSE • LONG PRESS TO EXIT',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white30,
                      fontSize: 9,
                      letterSpacing: 1.5),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _ticker() => SizedBox(
        height: 180,
        width: double.infinity,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final width = MediaQuery.sizeOf(context).width;
            final total = widget.items.length * width * .85;
            final offset = paused ? 0.0 : controller.value * total;
            return ClipRect(
              child: Stack(
                children: [
                  for (var i = 0; i < widget.items.length; i++)
                    Positioned(
                      left: (i * width * .85 - offset) %
                              (total + width) -
                          width * .1,
                      top: 25,
                      bottom: 25,
                      child: _tickerItem(widget.items[i]),
                    ),
                ],
              ),
            );
          },
        ),
      );

  Widget _tickerItem(FeedItem item) => SizedBox(
        width: MediaQuery.sizeOf(context).width * .85,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.source.toUpperCase(),
                  style: TextStyle(
                      color: widget.accent,
                      fontSize: 11,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text(item.title,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(color: widget.accent, blurRadius: 14)
                      ])),
              if (item.detail.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(item.detail,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                        color: item.positive
                            ? widget.accent
                            : const Color(0xFFFF5B72),
                        fontSize: widget.fontSize * .48,
                        fontWeight: FontWeight.bold)),
              ],
            ],
          ),
        ),
      );

  Widget _clock() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${_two(now.hour)}:${_two(now.minute)}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 90,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  shadows: [Shadow(color: widget.accent, blurRadius: 28)])),
          const SizedBox(height: 12),
          Text(
              '${now.year} / ${_two(now.month)} / ${_two(now.day)}',
              style: TextStyle(
                  color: widget.accent, fontSize: 22, letterSpacing: 5)),
          const SizedBox(height: 22),
          Text('SMART BAR • RGB EDITION',
              style: TextStyle(
                  color: widget.accent.withValues(alpha: .55),
                  letterSpacing: 4,
                  fontSize: 11)),
        ],
      );

  String _two(int value) => value.toString().padLeft(2, '0');
}

class GridPainter extends CustomPainter {
  const GridPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: .055)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) =>
      oldDelegate.color != color;
}
