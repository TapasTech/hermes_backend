# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_a = User.create!(email: 'adam@dtcj.com', password: '12345678', display_name: 'Adam')
user_b = User.create!(email: 'betty@dtcj.com', password: '12345678', display_name: 'Betty')
user_c = User.create!(email: 'cathy@dtcj.com', password: '12345678', display_name: 'Cathy')
user_d = User.create!(email: 'david@dtcj.com', password: '12345678', display_name: 'David')
user_e = User.create!(email: 'elizabeth@dtcj.com', password: '12345678', display_name: 'Elizabeth')
user_f = User.create!(email: 'fatimah@dtcj.com', password: '12345678', display_name: 'Fatimah')

user_a.follow(user_b)
user_a.follow(user_f)

user_b.follow(user_a)
user_b.follow(user_c)

user_c.follow(user_b)
user_c.follow(user_d)

user_d.follow(user_c)
user_d.follow(user_f)

user_f.follow(user_a)
user_f.follow(user_d)

t_p2p = Topic.create!(name: 'P2P')
t_efinance = Topic.create!(name: '互联网金融')
t_bigdata = Topic.create!(name: '大数据')
t_market  = Topic.create!(name: '消费行为')

data_report = DataReport.create(title: '天猫美妆: 2016中国美妆消费趋势报告', url: 'http://datareport.dtcj.com/pdf?name=2016%E4%B8%AD%E5%9B%BD%E7%BE%8E%E5%A6%86%E6%B6%88%E8%B4%B9%E8%B6%8B%E5%8A%BF%E6%8A%A5%E5%91%8A&report_path=http://images.dtcj.com/DTCJ/e130c46e4a9a6d2db857c4e5861ab36c2157d7b060eeefcd71eb247a56cdab9f&total_pages_num=99')

question = user_a.ask(title: '中国高端化妆品市场走势在2016将会怎么样?', content: '')
question.topics << t_bigdata
question.topics << t_market
question.topics << t_efinance
question.data_reports << data_report
user_a.follow_question(question)

question_2 = user_b.ask(title: '易付宝对金融市场产生什么影响?', content: '')
question_2.topics << t_p2p
question_2.topics << t_efinance
user_b.follow_question(question_2)

question.vote_by(user_a, 1)
question.vote_by(user_b, 1)
question.vote_by(user_c, -1)

question_2.vote_by(user_a, 1)
question_2.vote_by(user_b, 1)
question_2.vote_by(user_c, -1)
question_2.vote_by(user_d, 1)
question_2.vote_by(user_e, 1)
question_2.vote_by(user_f, -1)

answer_1 = user_b.answer(content: 'blah, blah, blah! BLAHBLAH!', question: question)
answer_1.data_reports << data_report

answer_2 = user_c.answer(content: 'Ummmmm....', question: question)

answer_1.vote_by(user_a, 1)
answer_1.vote_by(user_c, 1)
answer_1.vote_by(user_d, 1)
answer_1.vote_by(user_e, -1)

answer_2.vote_by(user_a, -1)
answer_2.vote_by(user_b, 1)
answer_2.vote_by(user_d, -1)
answer_2.vote_by(user_e, -1)
answer_2.vote_by(user_f, -1)
