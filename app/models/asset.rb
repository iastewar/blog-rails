class Asset < ActiveRecord::Base
  validates :file, presence: true
  belongs_to :post

  mount_uploader :file, FileUploader

end
