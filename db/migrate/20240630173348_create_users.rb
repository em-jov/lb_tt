class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest
      t.integer :login_failure_count, default: 0

      t.timestamps
    end
  end
end
