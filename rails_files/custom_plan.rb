require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def test(*args)
    require 'simplecov'
    SimpleCov.start 'rails'
    require 'factory_girl'
    FactoryGirl.reload
    ENV['GUARD_RSPEC_RESULTS_FILE'] = 'tmp/guard_rspec_results.txt'
    Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
    Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
    super
  end
end

Zeus.plan = CustomPlan.new
