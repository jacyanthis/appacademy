function inherits(childClass, parentClass) {
  var Surrogate = function () {};
  Surrogate.prototype = parentClass.prototype;
  childClass.prototype = new Surrogate();
  childClass.prototype.constructor = childClass;
};
