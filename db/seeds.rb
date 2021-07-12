# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(name: "user")
Role.create(name: "admin")
User.create(first_name: "Admin", last_name: "Anton", email: "luka14a@gmail.com", password: "123123", password_confirmation: "123123", role_id: 2)
User.create(first_name: "Bob", last_name: "Boo", email: "user@gmail.com", password: "123123", password_confirmation: "123123", role_id: 1)
User.create(first_name: "Mike", last_name: "MacMike", email: "user1@gmail.com", password: "123123", password_confirmation: "123123", role_id: 1)