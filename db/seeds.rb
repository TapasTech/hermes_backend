# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'adam@dtcj.com', password: '12345678', display_name: 'Adam')
User.create!(email: 'betty@dtcj.com', password: '12345678', display_name: 'Betty')

Topic.create!(name: 'P2P')
Topic.create!(name: '互联网金融')
t_bigdata = Topic.create!(name: '大数据')
t_market  = Topic.create!(name: '消费行为')

data_report = DataReport.create(title: '天猫美妆: 2016中国没装消费趋势报告', url: 'http://datareport.dtcj.com/pdf?name=2016%E4%B8%AD%E5%9B%BD%E7%BE%8E%E5%A6%86%E6%B6%88%E8%B4%B9%E8%B6%8B%E5%8A%BF%E6%8A%A5%E5%91%8A&report_path=http://images.dtcj.com/DTCJ/e130c46e4a9a6d2db857c4e5861ab36c2157d7b060eeefcd71eb247a56cdab9f&total_pages_num=99')

question = User.first.questions.create!(title: '中国高端化妆品市场走势在2016将会怎么样?', content: '')
question.topics << t_bigdata
question.topics << t_market
question.data_reports << data_report
