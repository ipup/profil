desc "Delete all unconfirmed users after 7 days"
task :postgre_delete_unconfirmed_users => :environment do
  users = User.all(:conditions => 'confirmed_at is NULL AND confirmation_sent_at <= current_date - integer \'7\' ')
  users.each do |user|
    user.destroy
  end
end
