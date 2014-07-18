class Product < ActiveRecord::Base
  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validate :price_must_be_a_cent
  validates_uniqueness_of :title
  validates_format_of :image_url,
                       :with => %r{.(png|jpg|jpeg)$}i,
                       :message => 'must be a URL for GIF, JPG ' + 'or PNG image.',
                       :multiline => true


  def self.find_product_for_sale
    Product.all.order('title')
  end

  protected

  def price_must_be_a_cent
    if price.nil? || price < 0.01
      errors.add(:price, 'should be a least 0.01')
    end
  end

end
