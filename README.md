# テーブル設計

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| product_name        | string     | null: false                    |
| product_description | text       | null: false                    |
| item_category       | string     | null: false                    |
| item_status         | string     | null: false                    |
| price               | integer    | null: false                    |
| user                | reference  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :buy

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |
| nickname           | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_kana     | string  | null: false |
| first_name_kana    | string  | null: false |
| birth_year         | integer | null: false |
| birth_month        | integer | null: false |
| birth_date         | integer | null: false |

### Association

- has_many :items
- has_many :buys

## buys テーブル

| Column            | Type       | Options                        |
| ------------------| ---------- | ------------------------------ |
| charge_style      | string     | null: false                    |
| shipping_region   | string     | null: false                    |
| shipping_date     | string     | null: false                    |
| user              | reference  | null: false, foreign_key: true |
| item              | reference  | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| state         | string     | null: false                    |
| locality      | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | integer    | null: false                    |
| buy           | reference  | null: false, foreign_key: true |

### Association

- belongs_to :buy