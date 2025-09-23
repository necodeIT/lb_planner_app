import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A spinner widget that allows the user to increment or decrement a number.
class NumberSpinner<T extends num> extends StatefulWidget {
  /// A spinner widget that allows the user to increment or decrement a number.
  const NumberSpinner({
    super.key,
    this.decrement,
    this.increment,
    this.inputFormatters,
    this.max,
    this.min,
    this.enabled,
    this.initialValue,
    this.onChanged,
    this.decoration,
  });

  /// The controller to use for the spinner. If null, the default behavior is to create a new controller.
  final T? initialValue;

  /// The controller to use for the spinner. If null, the default behavior is to create a new controller.
  final void Function(T)? onChanged;

  /// Callback to decrease the value. If null, the default behavior is to subtract 1 from the current value.
  final T Function(T)? decrement;

  /// Callback to increase the value. If null, the default behavior is to add 1 to the current value.
  final T Function(T)? increment;

  /// The input formatters to use for the spinner. If null, the default behavior is to allow only digits.
  final List<TextInputFormatter>? inputFormatters;

  /// The decoration to use for the spinner. If null, the default behavior is to use a standard decoration.
  final InputDecoration? decoration;

  /// The maximum value that the spinner can have. If null, there is no maximum value.
  final T? max;

  /// The minimum value that the spinner can have. If null, there is no minimum value.
  final T? min;

  /// Whether the spinner is enabled. If null, the default behavior is to enable the spinner.
  final bool? enabled;

  @override
  State<NumberSpinner> createState() => _NumberSpinnerState<T>();
}

class _NumberSpinnerState<T extends num> extends State<NumberSpinner<T>> {
  T _value = 0 as T;
  final TextEditingController controller = TextEditingController();
  TextSelection? selection;

  set value(T value) {
    _value = value;
    widget.onChanged?.call(value);
  }

  T get value => _value;

  @override
  void initState() {
    super.initState();

    _value = widget.initialValue ?? widget.min ?? 0 as T;
  }

  void increment() {
    setState(() {
      value = widget.increment?.call(value) ?? value + 1 as T;

      if (widget.max != null && value > widget.max!) {
        value = widget.max!;
      }

      selection = controller.selection;
      controller.text = value.toString();
    });
  }

  void decrement() {
    setState(() {
      value = widget.decrement?.call(value) ?? value - 1 as T;

      if (widget.min != null && value < widget.min!) {
        value = widget.min!;
      }

      selection = controller.selection;
      controller.text = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.text = value.toString();
    // TODO(mastermarcohd): when the length of the input text increases in length through the increment button it takes on the wrong selection
    if (selection != null) {
      if (selection!.start <= controller.text.length && selection!.end <= controller.text.length) {
        controller.selection = selection!;
      } else {
        controller.selection = TextSelection.collapsed(offset: controller.text.length);
      }
    }

    final enabled = widget.enabled ?? true;

    return TextField(
      enabled: widget.enabled,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        suffixIcon: IconButton(
          onPressed: enabled ? increment : null,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: const Icon(Icons.add),
        ),
        prefixIcon: IconButton(
          onPressed: enabled ? decrement : null,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: const Icon(Icons.remove),
        ),
      ),
      onChanged: (input) {
        if (input.isEmpty) {
          return;
        }

        final number = num.tryParse(input);

        if (number == null) {
          return;
        }

        if (widget.max != null && number > widget.max!) {
          value = widget.max!;
          return;
        }

        if (widget.min != null && number < widget.min!) {
          value = widget.min!;
          return;
        }

        selection = controller.selection;

        setState(() {
          value = number as T;
        });
      },
      textAlign: TextAlign.center,
      controller: controller,
      inputFormatters: widget.inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );
  }
}
