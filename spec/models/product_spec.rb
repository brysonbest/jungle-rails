require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: "Cool Rocks")
    end

    it "will save a product" do
      product = Product.create(name: "Opal", price: 2000, quantity: 50, category: @category)
      expect(product).to be_present
    end

    it "will not save product if no name is given" do
      product = Product.create(name: nil, price: 2000, quantity: 50, category: @category)
      expect(product.errors.full_messages).to include "Name can't be blank"
    end


    it "will not save product if no quantity is given" do
      product = Product.create(name: "Sapphire", price: 50000, quantity: nil, category: @category)
      expect(product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "will not save product if no category is given" do
      product = Product.create(name: "Diamond", price: 100000, quantity: 1, category: nil)
      expect(product.errors.full_messages).to include "Category can't be blank"
    end

  end
end


# validates :name, presence: true
# validates :price, presence: true
# validates :quantity, presence: true
# validates :category, presence: true