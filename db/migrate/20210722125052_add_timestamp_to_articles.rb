class AddTimestampToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :description
  end
end
