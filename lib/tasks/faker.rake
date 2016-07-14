namespace :faker do
  desc "create tasks"
  task tasks: :environment do
    100.times do
      task =
      Task.create do |t|
        t.name = Faker::StarWars.character
        t.description = Faker::Hipster.sentence
        t.user_id = 1
      end
      p task.id
    end
  end

end
