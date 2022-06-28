import 'package:sorted/src/sorting_strategy.dart';

/// A [SortingStrategy] which uses merge sort, a stable sorting algorithm
class MergeSortingStrategy<T> implements SortingStrategy<T> {
  const MergeSortingStrategy();

  @override
  void sort(List<T> list, Comparator<T> comparator) {
    mergeSort(list, compare: comparator);
  }
}

/* 
The following optimized merge sort implementation is taken from flutter's source code under the BSD 3-Clause License.

  Copyright 2014 The Flutter Authors. All rights reserved.

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above
        copyright notice, this list of conditions and the following
        disclaimer in the documentation and/or other materials provided
        with the distribution.
      * Neither the name of Google Inc. nor the names of its
        contributors may be used to endorse or promote products derived
        from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/// Limit below which merge sort defaults to insertion sort.
const int _kMergeSortLimit = 32;

/// Sorts a list between `start` (inclusive) and `end` (exclusive) using the
/// merge sort algorithm.
///
/// If `compare` is omitted, this defaults to calling [Comparable.compareTo] on
/// the objects. If any object is not [Comparable], this throws a [TypeError]
/// (The stack trace may call it `_CastError` or `_TypeError`, but to catch it,
/// use [TypeError]).
///
/// Merge-sorting works by splitting the job into two parts, sorting each
/// recursively, and then merging the two sorted parts.
///
/// This takes on the order of `n * log(n)` comparisons and moves to sort `n`
/// elements, but requires extra space of about the same size as the list being
/// sorted.
///
/// This merge sort is stable: Equal elements end up in the same order as they
/// started in.
///
/// For small lists (less than 32 elements), `mergeSort` automatically uses an
/// insertion sort instead, as that is more efficient for small lists. The
/// insertion sort is also stable.
void mergeSort<T>(
  List<T> list, {
  int start = 0,
  int? end,
  int Function(T, T)? compare,
}) {
  end ??= list.length;
  compare ??= _defaultCompare<T>();

  final int length = end - start;
  if (length < 2) {
    return;
  }
  if (length < _kMergeSortLimit) {
    _insertionSort<T>(list, compare: compare, start: start, end: end);
    return;
  }
  // Special case the first split instead of directly calling _mergeSort,
  // because the _mergeSort requires its target to be different from its source,
  // and it requires extra space of the same size as the list to sort. This
  // split allows us to have only half as much extra space, and it ends up in
  // the original place.
  final int middle = start + ((end - start) >> 1);
  final int firstLength = middle - start;
  final int secondLength = end - middle;
  // secondLength is always the same as firstLength, or one greater.
  final List<T> scratchSpace = List<T>.filled(secondLength, list[start]);
  _mergeSort<T>(list, compare, middle, end, scratchSpace, 0);
  final int firstTarget = end - firstLength;
  _mergeSort<T>(list, compare, start, middle, list, firstTarget);
  _merge<T>(
    compare,
    list,
    firstTarget,
    end,
    scratchSpace,
    0,
    secondLength,
    list,
    start,
  );
}

/// Returns a [Comparator] that asserts that its first argument is comparable.
Comparator<T> _defaultCompare<T>() {
  // If we specify Comparable<T> here, it fails if the type is an int, because
  // int isn't a subtype of comparable. Leaving out the type implicitly converts
  // it to a num, which is a comparable.
  return (T value1, T value2) =>
      (value1 as Comparable<dynamic>).compareTo(value2);
}

/// Sort a list between `start` (inclusive) and `end` (exclusive) using
/// insertion sort.
///
/// If `compare` is omitted, this defaults to calling [Comparable.compareTo] on
/// the objects. If any object is not [Comparable], this throws a [TypeError]
/// (The stack trace may call it `_CastError` or `_TypeError`, but to catch it,
/// use [TypeError]).
///
/// Insertion sort is a simple sorting algorithm. For `n` elements it does on
/// the order of `n * log(n)` comparisons but up to `n` squared moves. The
/// sorting is performed in-place, without using extra memory.
///
/// For short lists the many moves have less impact than the simple algorithm,
/// and it is often the favored sorting algorithm for short lists.
///
/// This insertion sort is stable: Equal elements end up in the same order as
/// they started in.
void _insertionSort<T>(
  List<T> list, {
  int Function(T, T)? compare,
  int start = 0,
  int? end,
}) {
  // If the same method could have both positional and named optional
  // parameters, this should be (list, [start, end], {compare}).
  compare ??= _defaultCompare<T>();
  end ??= list.length;

  for (int pos = start + 1; pos < end; pos++) {
    int min = start;
    int max = pos;
    final T element = list[pos];
    while (min < max) {
      final int mid = min + ((max - min) >> 1);
      final int comparison = compare(element, list[mid]);
      if (comparison < 0) {
        max = mid;
      } else {
        min = mid + 1;
      }
    }
    list.setRange(min + 1, pos + 1, list, min);
    list[min] = element;
  }
}

/// Performs an insertion sort into a potentially different list than the one
/// containing the original values.
///
/// It will work in-place as well.
void _movingInsertionSort<T>(
  List<T> list,
  int Function(T, T) compare,
  int start,
  int end,
  List<T?> target,
  int targetOffset,
) {
  final int length = end - start;
  if (length == 0) {
    return;
  }
  target[targetOffset] = list[start];
  for (int i = 1; i < length; i++) {
    final T element = list[start + i];
    int min = targetOffset;
    int max = targetOffset + i;
    while (min < max) {
      final int mid = min + ((max - min) >> 1);
      if (compare(element, target[mid] as T) < 0) {
        max = mid;
      } else {
        min = mid + 1;
      }
    }
    target.setRange(min + 1, targetOffset + i + 1, target, min);
    target[min] = element;
  }
}

/// Sorts `list` from `start` to `end` into `target` at `targetOffset`.
///
/// The `target` list must be able to contain the range from `start` to `end`
/// after `targetOffset`.
///
/// Allows target to be the same list as `list`, as long as it's not overlapping
/// the `start..end` range.
void _mergeSort<T>(
  List<T> list,
  int Function(T, T) compare,
  int start,
  int end,
  List<T> target,
  int targetOffset,
) {
  final int length = end - start;
  if (length < _kMergeSortLimit) {
    _movingInsertionSort<T>(list, compare, start, end, target, targetOffset);
    return;
  }
  final int middle = start + (length >> 1);
  final int firstLength = middle - start;
  final int secondLength = end - middle;
  // Here secondLength >= firstLength (differs by at most one).
  final int targetMiddle = targetOffset + firstLength;
  // Sort the second half into the end of the target area.
  _mergeSort<T>(list, compare, middle, end, target, targetMiddle);
  // Sort the first half into the end of the source area.
  _mergeSort<T>(list, compare, start, middle, list, middle);
  // Merge the two parts into the target area.
  _merge<T>(
    compare,
    list,
    middle,
    middle + firstLength,
    target,
    targetMiddle,
    targetMiddle + secondLength,
    target,
    targetOffset,
  );
}

/// Merges two lists into a target list.
///
/// One of the input lists may be positioned at the end of the target list.
///
/// For equal object, elements from `firstList` are always preferred. This
/// allows the merge to be stable if the first list contains elements that
/// started out earlier than the ones in `secondList`.
void _merge<T>(
  int Function(T, T) compare,
  List<T> firstList,
  int firstStart,
  int firstEnd,
  List<T> secondList,
  int secondStart,
  int secondEnd,
  List<T> target,
  int targetOffset,
) {
  // No empty lists reaches here.
  assert(firstStart < firstEnd);
  assert(secondStart < secondEnd);
  int cursor1 = firstStart;
  int cursor2 = secondStart;
  T firstElement = firstList[cursor1++];
  T secondElement = secondList[cursor2++];
  while (true) {
    if (compare(firstElement, secondElement) <= 0) {
      target[targetOffset++] = firstElement;
      if (cursor1 == firstEnd) {
        // Flushing second list after loop.
        break;
      }
      firstElement = firstList[cursor1++];
    } else {
      target[targetOffset++] = secondElement;
      if (cursor2 != secondEnd) {
        secondElement = secondList[cursor2++];
        continue;
      }
      // Second list empties first. Flushing first list here.
      target[targetOffset++] = firstElement;
      target.setRange(
        targetOffset,
        targetOffset + (firstEnd - cursor1),
        firstList,
        cursor1,
      );
      return;
    }
  }
  // First list empties first. Reached by break above.
  target[targetOffset++] = secondElement;
  target.setRange(
    targetOffset,
    targetOffset + (secondEnd - cursor2),
    secondList,
    cursor2,
  );
}
