# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150917055823) do

  create_table "apps_collaboration_prefs", force: :cascade do |t|
    t.integer  "channel_id"
    t.boolean  "active",     default: false, null: false
    t.integer  "ratio",      default: 200,   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "apps_collaboration_prefs", ["channel_id"], name: "index_apps_collaboration_prefs_on_channel_id"

  create_table "article_collections", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "picture"
    t.string   "slug"
    t.integer  "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "published"
    t.datetime "publish_at"
  end

  create_table "article_collections_articles", force: :cascade do |t|
    t.integer  "article_collection_id"
    t.integer  "article_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "article_collections_articles", ["article_collection_id"], name: "index_article_collections_articles_on_article_collection_id"
  add_index "article_collections_articles", ["article_id"], name: "index_article_collections_articles_on_article_id"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "approved"
    t.integer  "category",     default: 0, null: false
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "vidurl"
    t.string   "slug"
    t.text     "content_html"
    t.text     "summary_html"
    t.datetime "publish_at"
    t.string   "thumburl"
  end

  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true
  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "channel_categories", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  add_index "channel_categories", ["slug"], name: "index_channel_categories_on_slug"

  create_table "channels", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "notes"
    t.boolean  "managed",             default: true
    t.integer  "platform",            default: 0
    t.text     "apidata"
    t.datetime "publishedat"
    t.string   "thumbdefault"
    t.string   "thumbmed"
    t.string   "thumbhigh"
    t.boolean  "referral",            default: false
    t.integer  "reffedby"
    t.integer  "channel_category_id", default: 1,     null: false
    t.integer  "subscribers"
    t.integer  "ytvaverage"
    t.string   "old_url"
    t.string   "thumbuploaded"
    t.integer  "plan_id"
    t.integer  "subscription_id"
  end

  add_index "channels", ["plan_id"], name: "index_channels_on_plan_id"
  add_index "channels", ["slug"], name: "index_channels_on_slug"
  add_index "channels", ["subscription_id"], name: "index_channels_on_subscription_id"
  add_index "channels", ["user_id"], name: "index_channels_on_user_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "gallery_images", force: :cascade do |t|
    t.integer  "user_gallery_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "Url_thumb"
  end

  add_index "gallery_images", ["user_gallery_id"], name: "index_gallery_images_on_user_gallery_id"

  create_table "gift_voucher_items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "gift_voucher_id"
    t.integer  "product_id"
    t.integer  "discount"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "gift_voucher_items", ["gift_voucher_id"], name: "index_gift_voucher_items_on_gift_voucher_id"
  add_index "gift_voucher_items", ["product_id"], name: "index_gift_voucher_items_on_product_id"

  create_table "gift_vouchers", force: :cascade do |t|
    t.string   "name"
    t.string   "message"
    t.string   "to_text"
    t.string   "from_text"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "anonymous"
    t.integer  "status"
    t.integer  "to_user_id"
    t.integer  "from_user_id"
  end

  create_table "motion_graphic_collections", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.string   "preview"
  end

  create_table "motion_graphic_customizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "motion_graphic_id"
    t.text     "custom_field_data"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "motion_graphic_customizations", ["user_id"], name: "index_motion_graphic_customizations_on_user_id"

  create_table "motion_graphics", force: :cascade do |t|
    t.integer  "category",                     default: 0, null: false
    t.string   "vidurl"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "preview"
    t.integer  "motion_graphic_collection_id"
    t.text     "custom_fields"
    t.integer  "product_id"
    t.string   "title"
    t.text     "content"
    t.text     "content_html"
    t.text     "summary_html"
    t.boolean  "approved"
    t.datetime "publish_at"
    t.string   "thumburl"
  end

  add_index "motion_graphics", ["motion_graphic_collection_id"], name: "index_motion_graphics_on_motion_graphic_collection_id"
  add_index "motion_graphics", ["product_id"], name: "index_motion_graphics_on_product_id"
  add_index "motion_graphics", ["slug"], name: "index_motion_graphics_on_slug", unique: true
  add_index "motion_graphics", ["user_id"], name: "index_motion_graphics_on_user_id"

  create_table "news", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.integer  "category",     default: 0,     null: false
    t.string   "vidurl"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "slug"
    t.boolean  "staffonly",    default: false
    t.text     "content_html"
    t.text     "summary_html"
    t.datetime "publish_at"
    t.string   "thumburl"
    t.boolean  "approved"
  end

  add_index "news", ["slug"], name: "index_news_on_slug", unique: true
  add_index "news", ["user_id"], name: "index_news_on_user_id"

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.text     "custom"
    t.integer  "cost"
    t.datetime "ordered"
    t.datetime "requested"
    t.datetime "delivered"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "order_id"
    t.integer  "purchasable_id"
    t.string   "purchasable_type"
    t.integer  "user_id"
    t.string   "name"
    t.integer  "channel_id"
  end

  add_index "order_items", ["channel_id"], name: "index_order_items_on_channel_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"
  add_index "order_items", ["purchasable_type", "purchasable_id"], name: "index_order_items_on_purchasable_type_and_purchasable_id"
  add_index "order_items", ["user_id"], name: "index_order_items_on_user_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "notes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "type"
    t.integer  "gift_voucher_id"
    t.integer  "status"
  end

  add_index "orders", ["gift_voucher_id"], name: "index_orders_on_gift_voucher_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "credits"
    t.integer  "period"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "description"
    t.boolean  "includes_review", default: true
    t.boolean  "available",       default: true
  end

  create_table "ppipns", force: :cascade do |t|
    t.text     "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "presets", force: :cascade do |t|
    t.integer  "channel_id"
    t.string   "name"
    t.integer  "intro_template_id"
    t.boolean  "customizeintropervideo", default: false
    t.integer  "background_template_id"
    t.integer  "l3_template_id"
    t.integer  "endcard_template_id"
    t.string   "slug"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id"
  end

  add_index "presets", ["channel_id"], name: "index_presets_on_channel_id"
  add_index "presets", ["slug"], name: "index_presets_on_slug"
  add_index "presets", ["user_id"], name: "index_presets_on_user_id"

  create_table "products", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "preview"
    t.integer  "price"
    t.text     "description"
    t.text     "custom"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "fname"
    t.string   "lname"
    t.date     "birthday"
    t.string   "paypal"
    t.string   "skype"
    t.string   "country_code"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "nickname"
    t.string   "slug"
    t.string   "avatar"
    t.string   "bio"
    t.integer  "artist"
    t.integer  "advisor"
    t.boolean  "recruitertos",        default: false
    t.integer  "selected_channel_id"
    t.boolean  "onboarded"
  end

  add_index "profiles", ["nickname"], name: "index_profiles_on_nickname", unique: true
  add_index "profiles", ["selected_channel_id"], name: "index_profiles_on_selected_channel_id"
  add_index "profiles", ["slug"], name: "index_profiles_on_slug", unique: true
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "referrals", force: :cascade do |t|
    t.string   "email"
    t.integer  "channel_type"
    t.string   "channel_id"
    t.integer  "status"
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.string   "slug"
  end

  add_index "referrals", ["user_id"], name: "index_referrals_on_user_id"

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.integer  "reqtype",     default: 0, null: false
    t.integer  "status",      default: 0, null: false
    t.integer  "assigned_to"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "requests", ["channel_id"], name: "index_requests_on_channel_id"
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "channel_id"
    t.integer  "user_id"
    t.datetime "completed_at"
    t.datetime "scheduled_for"
    t.integer  "status",             default: 0, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "slug"
    t.string   "sexyname"
    t.integer  "total_score"
    t.integer  "content_score"
    t.integer  "subscribers",        default: 0
    t.integer  "channel_views",      default: 0
    t.integer  "videos",             default: 0
    t.text     "content_notes"
    t.integer  "optimization_score"
    t.text     "optimization_notes"
    t.integer  "promotion_score"
    t.text     "promotion_notes"
    t.integer  "engagement_score"
    t.text     "engagement_notes"
    t.text     "summary"
  end

  add_index "reviews", ["channel_id"], name: "index_reviews_on_channel_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "songs", force: :cascade do |t|
    t.integer  "category",     default: 0, null: false
    t.string   "vidurl"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "title"
    t.text     "content"
    t.text     "content_html"
    t.text     "summary_html"
    t.boolean  "approved"
    t.datetime "publish_at"
    t.string   "thumburl"
    t.integer  "mood"
    t.integer  "genre"
    t.string   "artist"
    t.integer  "product_id"
  end

  add_index "songs", ["product_id"], name: "index_songs_on_product_id"
  add_index "songs", ["slug"], name: "index_songs_on_slug", unique: true
  add_index "songs", ["user_id"], name: "index_songs_on_user_id"

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "paymethod"
    t.integer  "billingperiod"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
    t.decimal  "paypal_subscription_amount"
    t.string   "paypal_subscription_description"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "paypal_payment_token"
    t.datetime "last_payment_date"
    t.datetime "next_billing_date"
    t.decimal  "resubcredit",                     precision: 8, scale: 2, null: false
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "thumbnail_presets", force: :cascade do |t|
    t.integer  "channel_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "thumbnail_presets", ["channel_id"], name: "index_thumbnail_presets_on_channel_id"

  create_table "txes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "txtype",          default: 0, null: false
    t.integer  "currency",        default: 0, null: false
    t.integer  "direction",       default: 0, null: false
    t.integer  "amount_cents",    default: 0, null: false
    t.integer  "balance_cents",               null: false
    t.integer  "amount_credits",  default: 0, null: false
    t.integer  "balance_credits",             null: false
    t.string   "notes"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "order_id"
  end

  add_index "txes", ["order_id"], name: "index_txes_on_order_id"
  add_index "txes", ["user_id"], name: "index_txes_on_user_id"

  create_table "user_galleries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "gallery_type", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "channel_id"
  end

  add_index "user_galleries", ["channel_id"], name: "index_user_galleries_on_channel_id"
  add_index "user_galleries", ["user_id"], name: "index_user_galleries_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "baserole",               default: 0,     null: false
    t.integer  "staffrole",              default: 0,     null: false
    t.integer  "clientstatus",           default: 0,     null: false
    t.string   "refid"
    t.boolean  "recruiter",              default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "videos", force: :cascade do |t|
    t.integer  "channel_id"
    t.string   "name"
    t.integer  "progress"
    t.string   "uuid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "preset_id"
    t.string   "ytvid"
    t.string   "etag"
    t.datetime "published_at"
    t.text     "description"
    t.string   "thumbdefault"
    t.string   "thumbmed"
    t.string   "thumbhigh"
    t.integer  "ytviews"
    t.string   "thumbnail_local"
  end

  add_index "videos", ["channel_id"], name: "index_videos_on_channel_id"
  add_index "videos", ["slug"], name: "index_videos_on_slug", unique: true

end
