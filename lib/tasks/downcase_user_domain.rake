desc "Make sure that domain field are saved in downcase"
task :downcase_user_domain => :environment do
  users = User.all
  users.each do |user|
    user.domain = user.domain.downcase
    user.save
  end
end