# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.delete_all

Product.create(title: 'Letsfit Smart Watch, Fitness Tracker with Heart Rate Monitor',
rating: 4.6,
description:
%{Protect & monitor your health: 
Our Letsfit activity watch includes a bunch of new features, including: music control, even Stress training.
Making it more than just a health tracker},
image_url: 'fitness_tracker.jpg',
price: 30.59)
