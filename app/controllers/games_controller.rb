require 'json'
require 'open-uri'

class GamesController < ApplicationController
    def new
        alphabet = ("A".."Z").to_a

        @grid = generate_grid(alphabet)
    end

    def score
        grid = params[:grid]
        answer = params[:answer].upcase
    
        if (answer.split('') - grid.split('')) == []
            response = fetch_word(answer)
            if response["found"] == true
                @result = "Congratulations! #{answer} is a valid english Word!"
            else
                @result = "Sorry, #{answer} is not a valid english word!"
            end
        else
            @result = "Sorry but #{answer} can't be build out of #{grid.split('').join(',')}"

        end

    end



    private

    def generate_grid(arr)
        counter = 0
        sample = []

        while counter < 10
            sample << arr[rand(0...arr.length)]
            counter+= 1
        end
        return sample
    end

    def fetch_word(word) 
        url = "https://wagon-dictionary.herokuapp.com/#{word}"
        serialized = open(url).read
        response = JSON.parse(serialized)
        return response
    end
end
