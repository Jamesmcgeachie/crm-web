require "minitest/autorun"
require_relative './contact'

class TestContact < Minitest::Test
  def setup
    Contact.delete_all
    @contact = Contact.create("Foo", "Bar", {email: "foo@bar.com", notes: "some note"})
  end

  def test_all
    assert_equal [@contact], Contact.all
  end

  def test_find
    assert_equal @contact, Contact.find(1)
  end

  def test_full_name
    assert_equal "Foo Bar", @contact.full_name
  end

  def test_update_attribute
    @contact.update("notes", "some other note")
    assert_equal "some other note", @contact.notes
  end

  def test_search_by_attribute
    assert_equal [@contact], Contact.search_by_attribute("first_name", "Foo")
  end

  def test_delete
    @contact.delete
    assert [], Contact.all
  end
end