import 'package:test_vibe/core/utils/widget_utils.dart';
import 'package:test_vibe/core/widgets/quantity_counter/quantity_counter_theme.dart';
import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  const QuantityCounter({
    super.key,
    this.initial = 1,
    this.min = 1,
    this.max = 9999,
    this.theme,
    this.onChanged,
  });

  final int initial;
  final int min;
  final int max;
  final QuantityCounterTheme? theme;
  final void Function(int value)? onChanged;
  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  late final ValueNotifier<int> countNotifier;

  @override
  void initState() {
    super.initState();
    countNotifier = ValueNotifier(widget.initial);
    countNotifier.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(countNotifier.value);
      }
    });
  }

  @override
  void didUpdateWidget(covariant QuantityCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial) {
      countNotifier.value = widget.initial;
    }
    if (oldWidget.max != widget.max) {
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    countNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = widget.theme ?? QuantityCounterTheme.of(context);
    return Container(
      height: myTheme.size.height,
      width: myTheme.size.width,
      decoration: myTheme.counterDecorationStyle,
      child: IconTheme(
        data: myTheme.counterIconStyle,
        child: DefaultTextStyle(
          style: myTheme.counterTextStyle,
          child: Row(
            children: [
              Expanded(
                child: _buildButton(
                  onPressed: () {
                    if (countNotifier.value - 1 < widget.min) return;
                    countNotifier.value--;
                  },
                  icon: Icon(Icons.remove),
                ),
              ),
              Builder(
                builder: (context) => SizedBox(
                  width: getTextSize('${widget.max}', DefaultTextStyle.of(context).style).width,
                  child: ValueListenableBuilder(
                    valueListenable: countNotifier,
                    builder: (context, value, child) => Text(
                      '$value',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _buildButton(
                  onPressed: () {
                    if (countNotifier.value + 1 > widget.max) return;
                    countNotifier.value++;
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required VoidCallback onPressed, required Widget icon}) => InkResponse(
        onTap: onPressed,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: icon,
        ),
      );
}
