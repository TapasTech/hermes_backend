# encoding: UTF-8
# frozen_string_literal: true
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_160_303_075_826) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'activities', force: :cascade do |t|
    t.integer  'user_id'
    t.integer  'question_id'
    t.integer  'answer_id'
    t.jsonb    'payload'
    t.text     'verb'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_index 'activities', ['answer_id'], name: 'index_activities_on_answer_id', using: :btree
  add_index 'activities', ['created_at'], name: 'index_activities_on_created_at', using: :btree
  add_index 'activities', ['payload'], name: 'index_activities_on_payload', using: :btree
  add_index 'activities', ['question_id'], name: 'index_activities_on_question_id', using: :btree
  add_index 'activities', ['user_id'], name: 'index_activities_on_user_id', using: :btree
  add_index 'activities', ['verb'], name: 'index_activities_on_verb', using: :btree

  create_table 'answers', force: :cascade do |t|
    t.integer  'user_id'
    t.integer  'question_id'
    t.text     'content'
    t.datetime 'edited_at'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.datetime 'deleted_at'
    t.float    'confidence'
    t.float    'hot'
  end

  add_index 'answers', ['confidence'], name: 'index_answers_on_confidence', using: :btree
  add_index 'answers', ['deleted_at'], name: 'index_answers_on_deleted_at', using: :btree
  add_index 'answers', ['hot'], name: 'index_answers_on_hot', using: :btree
  add_index 'answers', ['question_id'], name: 'index_answers_on_question_id', using: :btree
  add_index 'answers', ['user_id'], name: 'index_answers_on_user_id', using: :btree

  create_table 'answers_data_reports', force: :cascade do |t|
    t.integer  'answer_id'
    t.integer  'data_report_id'
    t.datetime 'created_at',     null: false
    t.datetime 'updated_at',     null: false
  end

  add_index 'answers_data_reports', ['answer_id'], name: 'index_answers_data_reports_on_answer_id', using: :btree
  add_index 'answers_data_reports', ['data_report_id'], name: 'index_answers_data_reports_on_data_report_id', using: :btree

  create_table 'answers_data_sets', force: :cascade do |t|
    t.integer  'answer_id'
    t.integer  'data_set_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_index 'answers_data_sets', ['answer_id'], name: 'index_answers_data_sets_on_answer_id', using: :btree
  add_index 'answers_data_sets', ['data_set_id'], name: 'index_answers_data_sets_on_data_set_id', using: :btree

  create_table 'businesses', force: :cascade do |t|
    t.text     'name'
    t.integer  'parent_business_id'
    t.datetime 'created_at',         null: false
    t.datetime 'updated_at',         null: false
    t.datetime 'deleted_at'
  end

  add_index 'businesses', ['deleted_at'], name: 'index_businesses_on_deleted_at', using: :btree
  add_index 'businesses', ['name'], name: 'index_businesses_on_name', using: :btree
  add_index 'businesses', ['parent_business_id'], name: 'index_businesses_on_parent_business_id', using: :btree

  create_table 'comments', force: :cascade do |t|
    t.integer  'user_id'
    t.integer  'reply_to_id'
    t.integer  'answer_id'
    t.text     'content'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.datetime 'deleted_at'
  end

  add_index 'comments', ['answer_id'], name: 'index_comments_on_answer_id', using: :btree
  add_index 'comments', ['deleted_at'], name: 'index_comments_on_deleted_at', using: :btree
  add_index 'comments', ['reply_to_id'], name: 'index_comments_on_reply_to_id', using: :btree
  add_index 'comments', ['user_id'], name: 'index_comments_on_user_id', using: :btree

  create_table 'data_reports', force: :cascade do |t|
    t.text     'title'
    t.text     'url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.integer  'user_id'
  end

  add_index 'data_reports', ['deleted_at'], name: 'index_data_reports_on_deleted_at', using: :btree
  add_index 'data_reports', ['url'], name: 'index_data_reports_on_url', using: :btree
  add_index 'data_reports', ['user_id'], name: 'index_data_reports_on_user_id', using: :btree

  create_table 'data_sets', force: :cascade do |t|
    t.text     'title'
    t.text     'url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.integer  'user_id'
  end

  add_index 'data_sets', ['deleted_at'], name: 'index_data_sets_on_deleted_at', using: :btree
  add_index 'data_sets', ['url'], name: 'index_data_sets_on_url', using: :btree
  add_index 'data_sets', ['user_id'], name: 'index_data_sets_on_user_id', using: :btree

  create_table 'educations', force: :cascade do |t|
    t.integer  'user_id'
    t.text     'organization'
    t.text     'direction'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
    t.datetime 'deleted_at'
  end

  add_index 'educations', ['deleted_at'], name: 'index_educations_on_deleted_at', using: :btree
  add_index 'educations', ['direction'], name: 'index_educations_on_direction', using: :btree
  add_index 'educations', ['organization'], name: 'index_educations_on_organization', using: :btree
  add_index 'educations', ['user_id'], name: 'index_educations_on_user_id', using: :btree

  create_table 'employments', force: :cascade do |t|
    t.integer  'user_id'
    t.text     'employment'
    t.text     'position'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
  end

  add_index 'employments', ['deleted_at'], name: 'index_employments_on_deleted_at', using: :btree
  add_index 'employments', ['employment'], name: 'index_employments_on_employment', using: :btree
  add_index 'employments', ['position'], name: 'index_employments_on_position', using: :btree
  add_index 'employments', ['user_id'], name: 'index_employments_on_user_id', using: :btree

  create_table 'followments', force: :cascade do |t|
    t.integer  'follower_id'
    t.integer  'followee_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_index 'followments', ['followee_id'], name: 'index_followments_on_followee_id', using: :btree
  add_index 'followments', ['follower_id'], name: 'index_followments_on_follower_id', using: :btree

  create_table 'locations', force: :cascade do |t|
    t.integer  'user_id'
    t.text     'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
  end

  add_index 'locations', ['deleted_at'], name: 'index_locations_on_deleted_at', using: :btree
  add_index 'locations', ['name'], name: 'index_locations_on_name', using: :btree
  add_index 'locations', ['user_id'], name: 'index_locations_on_user_id', using: :btree

  create_table 'questions', force: :cascade do |t|
    t.integer  'user_id'
    t.text     'title'
    t.text     'content'
    t.datetime 'edited_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.float    'hot'
  end

  add_index 'questions', ['deleted_at'], name: 'index_questions_on_deleted_at', using: :btree
  add_index 'questions', ['hot'], name: 'index_questions_on_hot', using: :btree
  add_index 'questions', ['user_id'], name: 'index_questions_on_user_id', using: :btree

  create_table 'questions_data_reports', force: :cascade do |t|
    t.integer  'question_id'
    t.integer  'data_report_id'
    t.datetime 'created_at',     null: false
    t.datetime 'updated_at',     null: false
  end

  add_index 'questions_data_reports', ['data_report_id'], name: 'index_questions_data_reports_on_data_report_id', using: :btree
  add_index 'questions_data_reports', ['question_id'], name: 'index_questions_data_reports_on_question_id', using: :btree

  create_table 'questions_data_sets', force: :cascade do |t|
    t.integer  'question_id'
    t.integer  'data_set_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_index 'questions_data_sets', ['data_set_id'], name: 'index_questions_data_sets_on_data_set_id', using: :btree
  add_index 'questions_data_sets', ['question_id'], name: 'index_questions_data_sets_on_question_id', using: :btree

  create_table 'questions_followments', force: :cascade do |t|
    t.integer  'follower_id'
    t.integer  'followee_question_id'
    t.datetime 'created_at',           null: false
    t.datetime 'updated_at',           null: false
  end

  add_index 'questions_followments', ['followee_question_id'], name: 'index_questions_followments_on_followee_question_id', using: :btree
  add_index 'questions_followments', ['follower_id'], name: 'index_questions_followments_on_follower_id', using: :btree

  create_table 'questions_topics', force: :cascade do |t|
    t.integer  'question_id'
    t.integer  'topic_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_index 'questions_topics', ['question_id'], name: 'index_questions_topics_on_question_id', using: :btree
  add_index 'questions_topics', ['topic_id'], name: 'index_questions_topics_on_topic_id', using: :btree

  create_table 'topics', force: :cascade do |t|
    t.text     'name'
    t.text     'description'
    t.integer  'origin_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.datetime 'deleted_at'
  end

  add_index 'topics', ['deleted_at'], name: 'index_topics_on_deleted_at', using: :btree
  add_index 'topics', ['name'], name: 'index_topics_on_name', using: :btree
  add_index 'topics', ['origin_id'], name: 'index_topics_on_origin_id', using: :btree

  create_table 'users', force: :cascade do |t|
    t.text     'email'
    t.text     'password_digest'
    t.text     'display_name'
    t.text     'gender'
    t.integer  'business_id'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
    t.datetime 'deleted_at'
  end

  add_index 'users', ['business_id'], name: 'index_users_on_business_id', using: :btree
  add_index 'users', ['deleted_at'], name: 'index_users_on_deleted_at', using: :btree

  create_table 'votes', force: :cascade do |t|
    t.integer  'user_id'
    t.string   'votable_type'
    t.integer  'votable_id'
    t.integer  'weight'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
  end

  add_index 'votes', ['user_id'], name: 'index_votes_on_user_id', using: :btree
  add_index 'votes', %w(votable_type votable_id), name: 'index_votes_on_votable_type_and_votable_id', using: :btree
  add_index 'votes', ['weight'], name: 'index_votes_on_weight', using: :btree

  add_foreign_key 'activities', 'answers'
  add_foreign_key 'activities', 'questions'
  add_foreign_key 'activities', 'users'
  add_foreign_key 'answers', 'questions'
  add_foreign_key 'answers_data_reports', 'answers'
  add_foreign_key 'answers_data_reports', 'data_reports'
  add_foreign_key 'answers_data_sets', 'answers'
  add_foreign_key 'answers_data_sets', 'data_sets'
  add_foreign_key 'businesses', 'businesses', column: 'parent_business_id'
  add_foreign_key 'comments', 'answers'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'comments', 'users', column: 'reply_to_id'
  add_foreign_key 'data_reports', 'users'
  add_foreign_key 'data_sets', 'users'
  add_foreign_key 'educations', 'users'
  add_foreign_key 'employments', 'users'
  add_foreign_key 'followments', 'users', column: 'followee_id'
  add_foreign_key 'followments', 'users', column: 'follower_id'
  add_foreign_key 'locations', 'users'
  add_foreign_key 'questions', 'users'
  add_foreign_key 'questions_data_reports', 'data_reports'
  add_foreign_key 'questions_data_reports', 'questions'
  add_foreign_key 'questions_data_sets', 'data_sets'
  add_foreign_key 'questions_data_sets', 'questions'
  add_foreign_key 'questions_followments', 'questions', column: 'followee_question_id'
  add_foreign_key 'questions_followments', 'users', column: 'follower_id'
  add_foreign_key 'questions_topics', 'questions'
  add_foreign_key 'questions_topics', 'topics'
  add_foreign_key 'topics', 'topics', column: 'origin_id'
  add_foreign_key 'users', 'businesses'
  add_foreign_key 'votes', 'users'
end
