class ImageRoom < ApplicationRecord
  belongs_to :room
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment	:image,
                       presence: true,
                       content_type: { content_type: %r{\Aimage\/.*\Z} },
                       size: { less_than: 1.megabyte }
  def url_medium
    image.url(:medium)
  end

  def url(size)
    image.url(size.to_sym)
  end
end
