# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :full_name
      t.string :password_digest
      t.datetime :birth
      t.string :phone
      t.integer :gender
      t.datetime :remember_created_at
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unlock_token
      t.datetime :locked_at
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
