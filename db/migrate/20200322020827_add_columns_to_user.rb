class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_file_id, :bigint
    add_column :users, :row_number, :bigint
    add_column :users, :error_string, :string
  end
end
