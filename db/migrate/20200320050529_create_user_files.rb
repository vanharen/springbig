class CreateUserFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_files do |t|
      t.string :name

      t.timestamps
    end
  end
end
