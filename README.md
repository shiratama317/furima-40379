# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users テーブル

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| name               | string     | null: false                    |
| content            | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| shipping_fee       | string     | null: false                    |
| ship_from          | string     | null: false                    |
| ship_days          | string     | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- has_one_attached :image
- belongs_to :user
- has_one :order


## ordersテーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- has_one :address
- belongs_to :user


## addressesテーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| post_code          | string     | null: false                    |
| prefecture         | string     | null: false                    |
| municipalities     | string     | null: false                    |
| block_number       | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | string     | null: false                    |
| order              | references | null: false, foreign_key: true |

### Association

- belongs_to :order
