class UserRoom < ApplicationRecord
#ユーザーとチャットルームの関連付けの定義（中間テーブル）
  belongs_to :user
  belongs_to :room
end
