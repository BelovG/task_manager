FactoryGirl.define do
  factory :task do
    sequence(:name) {|i| "name#{i}" }
    sequence(:description) {|i| "description#{i}" }

    factory :task_with_file do
      file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'test_file.txt')) }
    end
  end
end
