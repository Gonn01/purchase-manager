import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

/// {@template DropdownItemLD}
/// Defines the items for the dropdown.
/// {@endtemplate}
class PMDropdownItem<T> {
  /// {@macro DropdownItemLD}
  PMDropdownItem({
    required this.value,
    required this.text,
  });

  /// The value of the item.
  final T value;

  /// The text for the item to be displayed.
  final String text;
}

/// {@template LDDropdown}
/// Dropdown widget.
/// {@endtemplate}
class PMDropdown<T> extends StatefulWidget {
  /// {@macro LDDropdown}
  const PMDropdown({
    required this.items,
    this.hintText = 'Select Item',
    this.onChanged,
    this.initialItem,
    this.hasSearch = false,
    super.key,
  });

  /// The hint text for the dropdown.
  final String hintText;

  /// If the dropdown has a search field.
  final bool hasSearch;

  /// The items for the dropdown.
  final List<PMDropdownItem<T>> items;

  /// The initial item to be selected.
  final PMDropdownItem<T>? initialItem;

  /// The callback when the value changes.
  final ValueChanged<PMDropdownItem<T>?>? onChanged;

  @override
  State<PMDropdown<T>> createState() => _PMDropdownState<T>();
}

class _PMDropdownState<T> extends State<PMDropdown<T>> {
  final textEditingController = TextEditingController();

  PMDropdownItem<T?>? selectedValue;

  bool isOpen = false;

  @override
  void initState() {
    if (widget.initialItem != null) selectedValue = widget.initialItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        dropdownSearchData: widget.hasSearch
            ? DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an item...',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff02B4A3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              )
            : null,
        hint: Text(
          widget.hintText,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        items: widget.items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item.value,
                child: Text(
                  item.text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff02B4A3),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        value: selectedValue?.value,
        onChanged: (value) {
          final selectedItem =
              widget.items.firstWhere((item) => item.value == value);
          widget.onChanged?.call(selectedItem);
          setState(() => selectedValue = selectedItem);
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: isOpen
                ? const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  )
                : BorderRadius.circular(14),
            boxShadow: const [],
            border: Border.all(
              color: const Color(0xff02B4A3),
            ),
            color: Colors.white,
          ),
          elevation: 2,
        ),
        onMenuStateChange: (isOpen) => setState(() => this.isOpen = isOpen),
        iconStyleData: const IconStyleData(
          iconSize: 25,
          iconEnabledColor: Color(0xff02B4A3),
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            color: Colors.white,
            boxShadow: const [],
            border: Border.all(
              color: Colors.grey.withValues(alpha: .3),
            ),
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 14),
        ),
      ),
    );
  }
}
