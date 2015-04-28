#INSERT INTO "users" ("created_at", "email", "encrypted_password", "role", "updated_at") VALUES (?, ?, ?, ?, ?)  
# [["created_at", "2015-04-26 12:46:28.095519"], ["email", "wordsbybird@gmail.com"], 
# ["encrypted_password", "$2a$10$8g5go9kfOJZU4jB8h2uXTuOBgcLV.LiQ7OFxgbaSEAatAOfdTc75."], 
# ["role", 0], ["updated_at", "2015-04-26 12:46:28.095519"]]
puts 'ADMIN USERS'
  user = User.find_or_create_by(email: ENV['ADMIN_EMAIL'].dup) do |u| 
    u.password = ENV['ADMIN_EMAIL'].dup
    u.password_confirmation = ENV['ADMIN_EMAIL'].dup
    u.role = "admin"
  end
  puts 'created : ' << user.email
  user.save!
