RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:all, :cleaner_for_context) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.before(:each) do |example|
    next if example.metadata[:cleaner_for_context]

    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    next if example.metadata[:cleaner_for_context]

    DatabaseCleaner.clean
  end

  config.after(:all, :cleaner_for_context) do
    DatabaseCleaner.clean
  end
end
