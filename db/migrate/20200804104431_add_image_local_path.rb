class AddImageLocalPath < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :picture_path, :string
  end
end
