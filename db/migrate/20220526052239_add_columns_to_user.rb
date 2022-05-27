class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :user_type, :string, default: User.user_types.keys[0]
    add_column :users, :dob, :datetime
    add_column :users, :spend_money, :decimal, default: 0.0
    add_column :users, :points, :integer, default: 0
  end
end
