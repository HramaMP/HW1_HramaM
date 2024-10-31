require 'date'

class Student
  attr_accessor :surname, :name, :date_of_birth

  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    self.date_of_birth = date_of_birth

    add_student
  end


  def date_of_birth=(dob)
    raise ArgumentError, 'Date of birth must be in the past' if dob > Date.today
    @date_of_birth = dob
  end

  def self.all_students
    @@students
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if Date.new(today.year, @date_of_birth.month, @date_of_birth.day) > today
    age
  end

  def add_student
    unless @@students.any? { |s| s.surname == @surname && s.name == @name && s.date_of_birth == @date_of_birth }
      @@students << self
    end
  end

  def remove_student
    @@students.delete_if { |s| s.surname == @surname && s.name == @name && s.date_of_birth == @date_of_birth }
  end

  def self.get_students_by_age(age)
    @@students.select { |s| s.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |s| s.name == name }
  end
end

student1 = Student.new("Ivanenko", "Ivan", Date.new(2000, 5, 15))
student2 = Student.new("Petrenko", "Petro", Date.new(2002, 3, 10))
student3 = Student.new("Ivanenko", "Anna", Date.new(2000, 5, 15))
student4 = Student.new("Shevchenko", "Taras", Date.new(1999, 10, 24))

begin
  duplicate_student = Student.new("Ivanenko", "Ivan", Date.new(2000, 5, 15))
rescue ArgumentError => e
  puts e.message
end

puts "Вік студента #{student1.name} #{student1.surname}: #{student1.calculate_age} років"
puts "Вік студента #{student2.name} #{student2.surname}: #{student2.calculate_age} років"

puts "\nСписок всіх студентів:"
Student.all_students.each do |student|
  puts "#{student.name} #{student.surname}, Дата народження: #{student.date_of_birth}, Вік: #{student.calculate_age}"
end

age_to_search = 24
students_by_age = Student.get_students_by_age(age_to_search)
puts "\nСтуденти віком #{age_to_search} років:"
students_by_age.each do |student|
  puts "#{student.name} #{student.surname}"
end

name_to_search = "Ivan"
students_by_name = Student.get_students_by_name(name_to_search)
puts "\nСтуденти з ім’ям #{name_to_search}:"
students_by_name.each do |student|
  puts "#{student.name} #{student.surname}"
end

puts "\nВидаляємо студента #{student1.name} #{student1.surname}"
student1.remove_student

puts "\nСписок студентів після видалення:"
Student.all_students.each do |student|
  puts "#{student.name} #{student.surname}"
end