require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'student'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new

class TestStudentUnit < Minitest::Test
  def setup
    @student1 = Student.new("Ivanenko", "Ivan", Date.new(2000, 5, 15))
    @student2 = Student.new("Petrenko", "Petro", Date.new(2002, 3, 10))
  end

  def test_calculate_age
    assert_equal 24, @student1.calculate_age, "Age should be 24"
    assert_equal 22, @student2.calculate_age, "Age should be 22"
  end

  def test_add_student_uniqueness
    initial_count = Student.all_students.size
    duplicate_student = Student.new("Ivanenko", "Ivan", Date.new(2000, 5, 15))
    assert_equal initial_count, Student.all_students.size, "Duplicates should not be added"
  end

  def test_get_students_by_age
    students = Student.get_students_by_age(24)
    assert_includes students, @student1
    refute_includes students, @student2
  end

  def test_get_students_by_name
    students = Student.get_students_by_name("Ivan")
    assert_includes students, @student1
    refute_includes students, @student2
  end

  def test_remove_student
    @student1.remove_student
    refute_includes Student.all_students, @student1, "Student should be removed"
  end
end