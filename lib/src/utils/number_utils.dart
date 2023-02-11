int findSmallestMissingPositive(List<int> list) {
  int n = list.length;

  // mark the indexes of positive numbers as negative
  for (int i = 0; i < n; i++) {
    int num = list[i];
    if (num > 0 && num <= n) {
      list[num - 1] = -list[num - 1];
    }
  }

  // find the first positive index
  int i;
  for (i = 0; i < n; i++) {
    if (list[i] > 0) {
      break;
    }
  }

  // return the smallest missing positive integer
  return i + 1;
}
