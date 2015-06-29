class Student
  
  attr_accessor :first_name, :last_name, :courses
  
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  
  def name
    first_name + " " + last_name
  end
  
  def enroll(course)
    if !(courses.include?(course))
      courses << course
      course.students << self
    end
  end
  
  def course_load
    course_load = {}
    courses.each { |course|
      if course_load[course.department] == nil
        course_load[course.department] = course.credits
      else
        course_load[course.department] += course.credits
      end
    }
    course_load
  end
  
end

class Course
  
  attr_accessor :name, :department, :credits, :students
  
  def initialize(name, department, credits)
    @name = name
    @department = department
    @credits = credits
    @students = []
  end
  
  def add_student(student)
    student.enroll(self)
  end
  
end

bob = Student.new("Bob","Bobson")
history = Course.new("intro","History Department", 3)
bob.enroll(history)
history.students.each {|student| puts(student.name)}
puts(bob.course_load)
    