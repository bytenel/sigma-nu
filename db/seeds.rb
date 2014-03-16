# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Article.create(title: "New Website", description: "Sigma Nu Epsilon Lambda got a new website!", date: Date.current, img_url: "http://upload.wikimedia.org/wikipedia/en/thumb/2/28/Sigmanucoatofarms.png/240px-Sigmanucoatofarms.png" )