# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating Statuses'

Status.find_or_create_by!(description: 'To Do')
Status.find_or_create_by!(description: 'Doing')
Status.find_or_create_by!(description: 'Done')

puts 'Creating a Few Tasks'

Task.find_or_create_by!(title: 'Study Neural Networks',
                        body: 'AI is cool. Learn more about it.',
                        status: Status.first)

Task.find_or_create_by!(title: 'Develop RoR sample application',
                        body: 'DO IT.',
                        status: Status.first)

Task.find_or_create_by!(title: 'Sleep',
                        body: 'Shouldn\'t be too hard',
                        status: Status.second)

Task.find_or_create_by!(title: 'Brush your teeth every day',
                        body: 'Yeah.',
                        status: Status.third)