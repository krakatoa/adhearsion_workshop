# encoding: utf-8

class MainController < Adhearsion::CallController

  before_call :filter

  def run
    answer

    say 'Welcome to Adhearsion Rio Customer Care'

    menu 'Please press 1 for account details. Press 2 to reach one of our agents. Press 3 for complaints. Press 5 to exit' do
      match 1 do
        # account details
      end

      match 2 do
        # call agent
      end

      match 3 do
        # complaints
      end

      timeout do
        say 'Input timed out, please choose an option.'
      end

      invalid do
        say 'Please choose a valid option.'
      end
    end

    hangup
  end

  def filter
    reject if call.from =~ /^11/
  end
end
