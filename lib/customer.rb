class Customer < ActiveRecord::Base
    has_many :reviews
    has_many :dishes, through: :reviews

    # def reviews 
    #     Review.all.select{|review| review.customer == self}
    # end

    # def dishes 
    #     self.reviews.map{|review| review.dish}
    # end
end 



