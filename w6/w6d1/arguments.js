function sum() {
  var args = Array.prototype.slice.call(arguments);
  return args.reduce(function (accum, el) {
    return accum + el;
  });
};

Function.prototype.myBind = function (context) {
  var args = Array.prototype.slice.call(arguments, 1);
  var fn = this;
  return function () {
    return fn.apply(context, args);
  };
}

function curriedSum(numArgs) {
  var numbers = [];
  var _curriedSum = function (num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return numbers.reduce(function (accum, el) {
        return accum + el;
      });
    } else {
      return _curriedSum;
    };
  };
  return _curriedSum;
};

Function.prototype.curry = function (numArgs) {
  var args = [];
  var fun = this;
  var _curriedFun= function (arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return fun.apply(fun, args);
    } else {
      return _curriedFun;
    };
  };
  return _curriedFun;
};
