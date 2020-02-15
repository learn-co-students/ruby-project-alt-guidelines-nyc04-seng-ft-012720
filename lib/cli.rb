require "tty-prompt"
class CommandLineInterface
    attr_accessor :prompt
    attr_reader :customer
        
    def initialize()
        @prompt = TTY::Prompt.new
    end

    def run
        welcome
        main_menu
    end

    def welcome
        print  "        ██████╗  █████╗ ████████╗██╗███╗   ██╗ ██████╗      █████╗ ██████╗ ██████╗ 
        ██╔══██╗██╔══██╗╚══██╔══╝██║████╗  ██║██╔════╝     ██╔══██╗██╔══██╗██╔══██╗
        ██████╔╝███████║   ██║   ██║██╔██╗ ██║██║  ███╗    ███████║██████╔╝██████╔╝
        ██╔══██╗██╔══██║   ██║   ██║██║╚██╗██║██║   ██║    ██╔══██║██╔═══╝ ██╔═══╝ 
        ██║  ██║██║  ██║   ██║   ██║██║ ╚████║╚██████╔╝    ██║  ██║██║     ██║     
        ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝╚═╝     ╚═╝     
                                                                                   
        ".colorize(:red)
        puts "This Is The Best App To Rate The Delicious Dishes".colorize(:yellow)
        puts "PIZZA DOUGH

        )   (    )
     (    ___  (
       _.'   `._  )
     .'         `.
   _(_____________)___".colorize(:red)
        



        puts "Please Enter Your Name".colorize(:yellow)
        customer_name = gets.chomp
        @customer = Customer.find_by(name: customer_name)
        if customer == nil
            @customer = Customer.create(name: customer_name)
            #customer.save
            puts "Welcome #{customer_name}".colorize(:yellow)
        else 
            puts "Welcome Back #{customer_name}".colorize(:yellow)
        end 
    end

     
    def main_menu
        option = prompt.select("What would you like to do?") do |menu|
            menu.choice "create review"
            menu.choice "read review"
            menu.choice "update review"
            menu.choice "delete review"
            menu.choice "exit".colorize(:red)
        end
        if option == "create review"
            create_review
        elsif option == "read review"
            read_review
        elsif option == "update review"
            update_review
        elsif option == "delete review"
            delete_review
        else option == "exit"
            exit
        end 
    end

    def create_review
         #create a review by getting 3 parts: 1)customer_id 2)dish_id 3) rating
          #get customer_id through current_user
            answer = prompt.select("Choose one of the item to rate") do |m|
                m.choice "Pizza"
                m.choice "Taco"
                m.choice "Kebab"
            end
            reviewer(answer)
            main_menu
        end 

        def reviewer(dish_name)
            
            puts "Did you enjoy #{dish_name} and what's your rating for #{dish_name}(1-10)"
            rate = gets.chomp.to_i
            dish = Dish.all.find { |dish| dish.name == dish_name }
            #binding.pry
            Review.create(dish_id: dish.id, customer_id: customer.id, rating: rate)
         end 
           
        def read_review
            Review.all.each do |review|
                puts "#{review.customer.name}, review of, #{review.dish.name}, rating #{review.rating}"
            end
            main_menu 
        end 

        def read_my_reviews
            @customer.reviews.reload
            @customer.reviews.each do |review|
                puts "#{review.customer.name}, review of, #{review.dish.name}, rating #{review.rating}"
            end    
        end 

        def update_review
            # binding.pry
            i = 0

            #@customer = Customer.find_by(name: $customer_name)
            #%w(foo bar).each_with_object({}) { |str, hsh| hsh[str] = str.upcase }
            options = @customer.reviews.each_with_object({}) do |review, hash|
                i += 1 
                hash["#{i}. #{customer.name}, review of, #{review.dish.name}, rating #{review.rating}" ] = review.id
            end
            choose = prompt.select("Which one do you wanna update",options)
            # binding.pry
            #customer.reviews[choose.first.to_i - 1]
            review = Review.find_by(id: choose.to_i)
            rating_change = prompt.ask("Enter Your new update for rating")
            review.rating = rating_change.to_i
            review.save
            read_my_reviews
            main_menu
        end 

        def delete_review
            #hash = Hash.new
            #%w(cat dog wombat).each_with_index { |item, index|
            #hash[item] = index
            opt = @customer.reviews.each_with_index.map do |review,index| 
                ["#{index}. #{@customer.name}, review of, #{review.dish.name}, rating #{review.rating}", review.id] 
            end.to_h
            #binding.pry
            choose = prompt.select("Which review do you want to delete",opt)
            review = Review.find_by(id: choose.to_i)
            review.destroy
            read_my_reviews
            main_menu
        end 

        def exit
            puts "THANK YOU FOR VISTING OUR RATING APP".colorize(:blue)
        end 


        

            
         
        



        
end


        