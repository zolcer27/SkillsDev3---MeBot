#require "./app"
# app.rb

require 'sinatra'
require "sinatra/reloader" if development?

require 'did_you_mean'  if development?
require 'better_errors'  if development?
require 'cocktail_library'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end


enable :sessions

greetings = ["Welcome!", "Hey!", "Nice to see you."]
greetings_AM = ["Good morning", "Morning", "Good morrow"]
greetings_PM = ["Good evening", "Good night", "Sleep tight"]

get '/' do
  redirect "/about"
end


get '/about' do
  time = Time.now
  if time.hour < 12
    greetings_AM.sample + ". A little about me. My app provides you with great event alternatives in town so that you don't get FOMO. You have visited times as of " + time.strftime("%Y-%m-%d %H:%M:%S")
  else
    greetings_PM.sample + ". A little about me. My app provides you with great event alternatives in town so that you don't get FOMO. You have visited times as of " + time.strftime("%Y-%m-%d %H:%M:%S")
  end
end



def print_sum_two_numbers a, b
  puts (a + b).to_i
end

get '/incoming/sms' do
  puts print_sum_two_numbers 20, 27
end

error 403 do
  "Access Forbidden"
end

get '/signup/:first_name/:number' do
  username = params[:first_name]
  usernum = params[:number]
  "Your username is " + username + "! Your number is " + usernum + "!"
end

secretcode = "chipmunk"



# post '/signup' do
#   if params[:secretcode].nil?
#     return 403
#   elsif params[:secretcode] == "chipmunk"
#     if params[:first_name] != "" && params[:number] != ""
#       "Wait for a sign from me ;)"
#     else
#       "Please enter correct information"
#     end
#   else
#     return 403
#   end
# end

# post '/signup' do
#   if params[:secretcode] == "chipmunk"
#     if params[:first_name] != "" && params[:number] != ""
#       "Wait for a sign from me ;)"
#     else
#       "Please enter correct information"
#     end
#   else
#     return 403
#   end
# end
#
# get "/test/conversation/?:from?/?:body?" do
#   if params[:body].nil? || params[:from].nil?
#     return "No Message or Sender"
#   end

  get "/signup/:code" do
    if params[:code] == secretcode
      erb :signup
    else
      return 403
    end
  end

  post "/signup" do
    if params[:code] == secretcode
        if params[:first_name] != "" && params[:number] != ""
          "you will receive a message soon from the bot"
        else
          "please fill the required fields"
        end
    else
      return 403
    end
  end

#get '/test/conversation' do
 # 403
 #end

#error 403 do
 # "Access Forbidden"
 #end


 # determine_response params[:body]


def determine_response body
  body = body.downcase.strip
  jokes = IO.readlines("jokes.txt")
  facts = IO.readlines("facts.txt")
  crack = ["lol", "lolol", "haha", "jaja", "hohoyt", "FUNNY RIGHT!", "XD"]
  what_commands = ["what", "functions", "features", "actions", "purpose", "what can you do?", "tell me about you", "tell me your features", "do you have any cool functions?"]

  case body
  when "hi","hello","hey","yo","wazzup","sup"
    puts "Hello! I'm Marshmellow. I won't let you get FOMO!"
  else
    puts "Error HAHA"
  end

  # if body == "hi" or "hello" or "hey" or "yo" or "wazzup" or "sup"
  #   "Hello! I'm Marshmellow. I won't let you get FOMO!"
  # elsif body == "who"
  #   "Hi there! This is a MeBot and my name is Marshmellow. To meet my creator, Zeynep, and learn some facts about her, say fact!"
  # elsif body == "what", "help", "help me"
  #   "I am a bot that you can ask basic facts about my developer. I can also connect you to events she goes in your city."
  # elsif body == "where"
  #   "My developer and I are based in Pittsburgh. So come say hi!"
  # elsif body == "when"
  #   "Marshmellow was born in Fall 2018"
  # elsif body == "why"
  #   "Marshmellow was made for a class project in Programming for Online Prototypes course"
  # elsif body == "joke"
  #   return jokes.sample + crack.sample
  # elsif body == "haha", "lol", "jaja"
  #   return ["funny right?", "i know i'm funny", "Wanna hear another joke? Just say: joke"].sample
  # elsif body == "fact", "facts"
  #   return facts.sample
  # else
  #   "I don't understand what you mean. You can say: hi, who, what, where, when, why."
  # end
end