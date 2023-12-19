import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/utils/meta.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';

enum LetterAlignment { left, right }

class AlphabetScrollView extends StatefulWidget {
  AlphabetScrollView(
      {Key? key,
        required this.list,
        this.alignment = LetterAlignment.right,
        this.isAlphabetsFiltered = true,
        this.overlayWidget,
        required this.selectedTextStyle,
        required this.unselectedTextStyle,
        this.itemExtent = 40,
        required this.itemBuilder})
      : super(key: key);


  final List<AlphaModel> list;
  final double itemExtent;
  final LetterAlignment alignment;
  final bool isAlphabetsFiltered;

  /// Widget to show beside the selected alphabet
  /// if not specified it will be hidden.
  /// ```
  /// overlayWidget:(value)=>
  ///    Container(
  ///       height: 50,
  ///       width: 50,
  ///       alignment: Alignment.center,
  ///       color: Theme.of(context).primaryColor,
  ///       child: Text(
  ///                 '$value'.toUpperCase(),
  ///                  style: TextStyle(fontSize: 20, color: Colors.white),
  ///              ),
  ///      )
  /// ```

  final Widget Function(String)? overlayWidget;

  /// Text styling for the selected alphabet by which
  /// we can customize the font color, weight, size etc.
  /// ```
  /// selectedTextStyle:
  ///   TextStyle(
  ///     fontWeight: FontWeight.bold,
  ///     color: Colors.black,
  ///     fontSize: 20
  ///   )
  /// ```

  final TextStyle selectedTextStyle;

  /// Text styling for the unselected alphabet by which
  /// we can customize the font color, weight, size etc.
  /// ```
  /// unselectedTextStyle:
  ///   TextStyle(
  ///     fontWeight: FontWeight.normal,
  ///     color: Colors.grey,
  ///     fontSize: 18
  ///   )
  /// ```

  final TextStyle unselectedTextStyle;

  /// The itemBuilder must return a non-null widget and the third paramter id specifies
  /// the string mapped to this widget from the ```[list]``` passed.

  Widget Function(BuildContext, int, String) itemBuilder;

  @override
  _AlphabetScrollViewState createState() => _AlphabetScrollViewState();
}

class _AlphabetScrollViewState extends State<AlphabetScrollView> {
  void init() {
    widget.list
        .sort((x, y) => x.key.toLowerCase().compareTo(y.key.toLowerCase()));
    _list = widget.list;
    setState(() {});

    if (widget.isAlphabetsFiltered) {
      List<String> temp = [];
      alphabets.forEach((letter) {
        AlphaModel? firstAlphabetElement = _list.firstWhereOrNull(
                (item) => item.key.toLowerCase().startsWith(letter.toLowerCase()));
        if (firstAlphabetElement != null) {
          temp.add(letter);
        }
      });
      _filteredAlphabets = temp;
    } else {
      _filteredAlphabets = alphabets;
    }
    calculateFirstIndex();
    setState(() {});
  }

  @override
  void initState() {
    init();
    if (listController.hasClients) {
      maxScroll = listController.position.maxScrollExtent;
    }
    super.initState();
  }

  ScrollController listController = ScrollController();
  final _selectedIndexNotifier = ValueNotifier<int>(0);
  final positionNotifer = ValueNotifier<Offset>(const Offset(0, 0));
  final Map<String, int> firstIndexPosition = {};
  List<String> _filteredAlphabets = [];
  final letterKey = GlobalKey();
  List<AlphaModel> _list = [];
  bool isLoading = false;
  bool isFocused = false;
  final key = GlobalKey();

  @override
  void didUpdateWidget(covariant AlphabetScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.list != widget.list ||
        oldWidget.isAlphabetsFiltered != widget.isAlphabetsFiltered) {
      _list.clear();
      firstIndexPosition.clear();
      init();
    }
  }

  int getCurrentIndex(double vPosition) {
    double kAlphabetHeight = letterKey.currentContext!.size!.height;
    return (vPosition ~/ kAlphabetHeight);
  }

  void calculateFirstIndex() {
    _filteredAlphabets.forEach((letter) {
      AlphaModel? firstElement = _list.firstWhereOrNull(
              (item) => item.key.toLowerCase().startsWith(letter));
      if (firstElement != null) {
        int index = _list.indexOf(firstElement);
        firstIndexPosition[letter] = index;
      }
    });
  }

  // void scrolltoIndex(int x, Offset offset) {
  //   int index = firstIndexPosition[_filteredAlphabets[x].toLowerCase()]!;
  //   final scrollToPosition = widget.itemExtent * index;
  //   if (index != null) {
  //     listController.animateTo(
  //       scrollToPosition + (index > 0 ? 1 : 0) * widget.itemExtent,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   }
  //   positionNotifer.value = offset;
  // }

  void scrolltoIndex(int x, Offset offset) {
    String selectedLetter = _filteredAlphabets[x].toLowerCase();

    // Find the index of the heading for the selected alphabet
    int headingIndex = _list.indexWhere((item) =>
        item.key.toLowerCase().startsWith(selectedLetter));

    if (headingIndex != -1) {
      // Get the index of the first item after the heading
      int targetIndex = headingIndex + 1;

      // Scroll to the position of the first item after the heading
      listController.animateTo(
        targetIndex * 44, // Use actual item height instead of assumed value
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    positionNotifer.value = offset;
  }





  void onVerticalDrag(Offset offset) {
    int index = getCurrentIndex(offset.dy);
    if (index < 0 || index >= _filteredAlphabets.length) return;
    _selectedIndexNotifier.value = index;
    setState(() {
      isFocused = true;
    });
    scrolltoIndex(index, offset);
  }

  double? maxScroll;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: listController,
          scrollDirection: Axis.vertical,
          itemCount: _list.length,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (_, x) {
            String currentLetter = _list[x].key[0].toUpperCase();
            if (x == 0 || currentLetter != _list[x - 1].key[0].toUpperCase()) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 49),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          border: Border(
                          bottom: BorderSide(
                          color: lighterGrey,
                          width: 2.0,
                          ),
                      )),
                      child: Text(
                        currentLetter,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          fontFamily: 'Rubik',
                          color: tealColor
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 49),
                    width: MediaQuery.of(context).size.width,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: widget.itemExtent),
                      child: widget.itemBuilder(_, x, _list[x].key),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 49),
                width: MediaQuery.of(context).size.width,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: widget.itemExtent),
                  child: widget.itemBuilder(_, x, _list[x].key),
                ),
              );
            }
          },
        ),
        Align(
          alignment: widget.alignment == LetterAlignment.left
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            width: 32,
            decoration: BoxDecoration(
              color: pageProminent,
              borderRadius: BorderRadius.circular(32),
            ),
            key: key,
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: (z) => onVerticalDrag(z.localPosition),
                onVerticalDragUpdate: (z) => onVerticalDrag(z.localPosition),
                onVerticalDragEnd: (z) {
                  setState(() {
                    isFocused = false;
                  });
                },
                child: ValueListenableBuilder<int>(
                  valueListenable: _selectedIndexNotifier,
                  builder: (context, int selected, Widget? child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _filteredAlphabets.length,
                            (x) => GestureDetector(
                          key: x == selected ? letterKey : null,
                          onTap: () {
                            _selectedIndexNotifier.value = x;
                            scrolltoIndex(x, positionNotifer.value);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            child: Text(
                              _filteredAlphabets[x].toUpperCase(),
                              style: selected == x
                                  ? widget.selectedTextStyle
                                  : widget.unselectedTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        !isFocused
            ? Container()
            : ValueListenableBuilder<Offset>(
          valueListenable: positionNotifer,
          builder: (BuildContext context, Offset position, Widget? child) {
            return Positioned(
              right: widget.alignment == LetterAlignment.right ? 50 : null,
              left: widget.alignment == LetterAlignment.left ? 40 : null,
              top: position.dy + MediaQuery.of(context).size.height*0.1,
              child: widget.overlayWidget == null
                  ? Container()
                  : widget.overlayWidget!(_filteredAlphabets[
              _selectedIndexNotifier.value]),
            );
          },
        ),
      ],
    );
  }

}

class AlphaModel {
  final String key;
  final String? secondaryKey;

  AlphaModel(this.key, {this.secondaryKey});
}