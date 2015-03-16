# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'admin@mail.com',
             password:              'password',
             password_confirmation: 'password',
             admin: true)

Creator.create!(user: 'Hades',
                password:              'password',
                password_confirmation: 'password')
Creator.create!(user: 'Kalle',
                password:              'password',
                password_confirmation: 'password')
Creator.create!(user: 'Olle',
                password:              'password',
                password_confirmation: 'password')
Key.create!(user_id: 1,
                key:              '12345')

Position.create!(long: 13.157423,
                  latt: 55.376243)


Tag.create!(name: 'Simma',)

Event.create!(tags: Tag.all,
              position_id: 1,
              creator_id: 1,
              title: "Mysterit i skogen",
            description: 'Nu ska vi ha kul')
