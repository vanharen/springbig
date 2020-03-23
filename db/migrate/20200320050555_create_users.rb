class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
