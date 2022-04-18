class CreateCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :credentials do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.string :public_key
      t.integer :sign_count
      t.binary :raw_id

      t.timestamps
    end
    add_index :credentials, %i{name user_id}, unique: true
  end
end
