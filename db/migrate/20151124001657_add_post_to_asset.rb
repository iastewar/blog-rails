class AddPostToAsset < ActiveRecord::Migration
  def change
    add_reference :assets, :post, index: true, foreign_key: true
  end
end
