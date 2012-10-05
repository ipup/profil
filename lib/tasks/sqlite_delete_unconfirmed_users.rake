desc "Delete all unconfirmed users after 7 days"
task :sqlite_delete_unconfirmed_users => :environment do
  users = User.all(:conditions => 'confirmed_at is NULL AND confirmation_sent_at <= datetime(\'now\',\'-7 days\')')
  users.each do |user|
    user.destroy
  end
end
