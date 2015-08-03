function Clock() {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  console.log(this.current.toTimeString());
};

Clock.prototype.run = function () {
  this.current = new Date();
  this.printTime();
  var that = this;
  var cycle = function() {
    setTimeout(function () {
      that._tick();
      cycle();
    }, Clock.TICK);
  }
  cycle();
};

Clock.prototype._tick = function () {
  this.current.setSeconds(this.current.getSeconds() + Clock.TICK / 1000);
  this.printTime();
};

// var clock = new Clock();
// clock.run();

var readline = require("readline");

reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("What is the next number?\n", function (number) {
      sum += parseInt(number);
      console.log(sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    })
  } else {
    completionCallback(sum);
    reader.close();
  };
}

// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
// });

function askIfGreaterThan(el1, el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + "?\n", function (answer) {
    if (answer === "yes") {
      callback(true);
    } else {
      callback(false);
    }
  })
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  // Do an "async loop":
  // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
  //    know whether any swap was made.
  // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
  //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
  //    continue the inner loop. You'll want to increment i for the
  //    next call, and possibly switch madeAnySwaps if you did swap.

  if (i == arr.length - 1) {
    outerBubbleSortLoop(madeAnySwaps);
  } else {
    askIfGreaterThan(arr[i], arr[i + 1], function (swap) {
      if (swap) {
        var temp = arr[i + 1];
        arr[i + 1] = arr[i];
        arr[i] = temp;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    })
  }
}

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    // Begin an inner loop if `madeAnySwaps` is true, else call
    // `sortCompletionCallback`.
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
  // Kick the first outer loop off, starting `madeAnySwaps` as true.
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
