class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :log_type
      t.binary :data
      t.datetime :created_at
    end
  end
end