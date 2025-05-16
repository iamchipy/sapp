class AddShortCodeToLinks < ActiveRecord::Migration[8.0]
  def change
    add_column :links, :short_code, :string
  end
end
