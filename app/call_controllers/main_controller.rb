# encoding: utf-8

require 'sequel'
DB = Sequel.sqlite :database => File.join(Adhearsion.root, "accounts.db")

class MainController < Adhearsion::CallController

  before_call :filter

  def run
    answer

    @tries = 0

    say 'Welcome to Adhearsion Rio Customer Care'

    while @tries < 3 do
      main_menu
    end

    bye
  end

  def main_menu
    menu 'Please press 1 for account details. Press 2 to reach one of our agents. Press 3 for complaints. Press 5 to exit.' do
      match 1 do
        invoke AccountMenuController
        get_to_main
      end

      match 2 do
        status = dial "user/1000", :for => 20
        
        case status.result
          when :answer
            bye
          when :error, :timeout
            say 'All of our agents are currently busy, please try again later.'
        end
      end

      match 3 do
        say 'Please, leave a message after the beep.'
        result = record max_duration: 30
        puts "Recorded file: #{result.recording_uri}"
      end

      match 5 do
        bye
      end

      timeout do
        say 'Input timed out, please choose an option.'
      end

      invalid do
        @tries += 1
        say 'Please choose a valid option.'
      end
    end
  end

  def get_to_main
    menu 'If you want to get to the main menu, please press 1. If you want to exit, press 2.' do
      match 1 do
        @tries = 0
        main_menu
      end

      match 2 do
        bye
      end
    end
  end

  def bye
    say 'Good bye.'
    hangup
  end

  def filter
    reject if call.from =~ /^11/
  end
end
