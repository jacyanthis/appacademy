Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    fn.apply(context);
  }
}

var funkyFunc = function () {
  console.log(this);
}

var boundFunkyFunc = funkyFunc.myBind({ something: "thing"});

boundFunkyFunc();
