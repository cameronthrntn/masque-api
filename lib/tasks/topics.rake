namespace :topics do
  desc "Autoamcatically deletes all topics older than 2 hours"
  task auto_delete: :environment do
    puts 'deleting tasks'
    topics = Topic.where(['created_at < ?', 2.hours.ago])
    puts topics.length
    topics.delete_all
  end
end
