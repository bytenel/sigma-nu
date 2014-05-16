# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "admin@admin.com", password: "password", password_confirmation: "password", username: "admin").assign_admin_role
Article.create(title: "New Website", body: "Sigma Nu Epsilon Lambda got a new website!", date: Date.current)
Forum.create(title: "Sigma Nu", description: "Banter about the house.", category_id: 1)
AdminUser.create(email: "admin@example.com", password: "password")