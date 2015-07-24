var Student = function (options) {
  this.fname = options["fname"];
  this.lname = options["lname"];
  this.courses = [];
}

Student.prototype.name = function () {
  console.log(this.fname + " " + this.lname);
}

Student.prototype.print_courses = function () {
  for (var i = 0; i < this.courses.length; i++) {
    console.log(this.courses[i].name)
  }
}

Student.prototype.enroll = function (course) {
  if (this.courses.indexOf(course) === -1) {
    this.courses.push(course);
    course.students.push(this);
  }
}

Student.prototype.course_load = function () {
  obj = {}
  for (var i = 0; i < this.courses.length; i++) {
    if (obj[this.courses[i].department] !== undefined) {
      obj[this.courses[i].department] += this.courses[i].credits
    } else {
      obj[this.courses[i].department] = this.courses[i].credits
    }
  }

  return obj;
}

var Course = function (options) {
  this.name = options["name"];
  this.department = options["department"];
  this.credits = options["credits"];
  this.students = [];
}

Course.prototype.add_student = function (student) {
  student.enroll(this);
}

var bob = new Student({fname: "Bob", lname: "The Conqueror"});
var destiny = new Student({fname: "Destiny", lname: "The Dreadful"});

var gym = new Course({name: "Gym", department: "Phys Ed", credits: 2});
var archery = new Course({name: "Archery", department: "Phys Ed", credits: 3});
var conquering = new Course({name: "Conquering", department: "War", credits: 4});
