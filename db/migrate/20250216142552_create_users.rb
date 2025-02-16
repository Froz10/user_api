class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :email
      t.string :nationality
      t.string :country
      t.string :gender
      t.integer :age
      t.string :user_full_name

      t.timestamps
    end
  end
end
