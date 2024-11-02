require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'student'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new

describe Student do
  before do
    @student1 = Student.new("Ivanenko", "Ivan", Date.new(2000, 5, 15))
    @student2 = Student.new("Petrenko", "Petro", Date.new(2002, 3, 10))
  end

  describe "calculate_age" do
    it "returns correct age for student1" do
      _(@student1.calculate_age).must_equal 24
    end

    it "returns correct age for student2" do
      _(@student2.calculate_age).must_equal 22
    end
  end

  describe "add_student" do
    it "does not add duplicate students" do
      initial_count = Student.all_students.size
      Student.new("Ivanenko", "Ivan", Date.new(2000, 5, 15))
      _(Student.all_students.size).must_equal initial_count
    end
  end

  describe "get_students_by_age" do
    it "finds students by specified age" do
      students = Student.get_students_by_age(24)
      _(students).must_include @student1
      _(students).wont_include @student2
    end
  end

  describe "get_students_by_name" do
    it "finds students by specified name" do
      students = Student.get_students_by_name("Ivan")
      _(students).must_include @student1
      _(students).wont_include @student2
    end
  end

  describe "remove_student" do
    it "removes the specified student" do
      @student1.remove_student
      _(Student.all_students).wont_include @student1
    end
  end
end