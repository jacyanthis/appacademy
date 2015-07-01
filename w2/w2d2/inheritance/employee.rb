require 'byebug'

class Employee

  attr_accessor :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end

  def total_salary
    salary
  end

end


class Manager < Employee

  attr_accessor :name, :title, :salary, :employees, :boss

  def initialize(name, title, salary, employees, boss = nil)
    super(name, title, salary, boss)

    @employees = employees
  end


  def bonus(multiplier)

    result = 0
    employees.each do |employee|
      result += employee.bonus(multiplier)
      result += employee.salary * multiplier if employee.is_a?(Manager)
    end

    result
  end
end

ned = Manager.new("Ned", "Founder", 1_000_000, [])
darren = Manager.new("Darren", "TA Manager", 78_000, [])
shawna = Employee.new("Shawna", "TA", 12_000, darren)
david = Employee.new("David", "TA", 10_000, darren)
darren.employees = [david, shawna]
ned.employees = [darren]
puts ned.bonus(5)
p darren.bonus(4) # => 88_000
p david.bonus(3)
