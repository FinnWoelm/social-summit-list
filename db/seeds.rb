# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Summit.create(
  name: 'Test',
  description: 'SAMPLE SAMPLE SAMPLE',
  deadline: '{
    "content":[
    {"text": "lol",
     "date": "2014-11-12"}
    ]
  }',
  location_city: 'Boulder',
  location_country: 'USA',
  language: 'English',
  date_start: '2014-11-26',
  date_end: '2014-11-30',
  cost: '100',
  currency: '$',
  fields: 'all',
  contact_website: 'http://www.facebook.com/',
  contact_email: 'finn.woelm@gmail.com',
  admin_email: 'finn.woelm@gmail.com',
  admin_url: 'testabc'
  )

Summit.create(
  name: 'ATest2',
  description: 'SAMPLE SAMPLE SAMPLE',
  deadline: '{
    "content":[
    {"text": "lol",
     "date": "2014-11-12"}
    ]
  }',
  location_city: 'Boulder',
  location_country: 'USA',
  language: 'English',
  date_start: '2014-11-26',
  date_end: '2014-11-30',
  cost: '100',
  currency: '$',
  fields: 'all',
  admin_email: 'finn.woelm@gmail.com',
  admin_url: 'testabc'
  )

Summit.create(
  name: 'ZTes3t',
  description: 'SAMPLE SAMPLE SAMPLE',
  deadline: '{
    "content":[
    {"text": "lol",
     "date": "2014-11-12"}
    ]
  }',
  location_city: 'Boulder',
  location_state: 'CO',
  location_country: 'USA',
  language: 'English',
  date_start: '2014-11-26',
  date_end: '2014-11-30',
  cost: '5000',
  currency: '€',
  fields: 'all',
  admin_email: 'finn.woelm@gmail.com',
  admin_url: 'testabc'
  )

Summit.create(
  name: 'XXATest4',
  description: 'SAMPLE SAMPLE SAMPLE',
  deadline: '{
    "content":[
    {"text": "lol",
     "date": "2014-11-12"}
    ]
  }',
  location_city: 'Boulder',
  location_country: 'USA',
  language: 'English',
  date_start: '2014-11-26',
  date_end: '2014-11-30',
  cost: '50',
  currency: '€',
  fields: 'all',
  admin_email: 'finn.woelm@gmail.com',
  admin_url: 'testabc'
  )