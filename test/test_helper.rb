ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocktail"

class UnitTest < ActiveSupport::TestCase
  include Mocktail::DSL

  teardown do
    Mocktail.reset
  end

  protected

  def verify_no_calls!(mock, method_name)
    assert_equal 0, Mocktail.calls(mock, method_name).size
  end
end

class ActiveSupport::TestCase
  make_my_diffs_pretty!

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
