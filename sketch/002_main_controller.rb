# encoding: utf-8

class MainController < Adhearsion::CallController

  before_call :filter

  def run
    answer

    say 'Welcome to Adhearsion Rio Customer Care'

    menu 'Please press 1 for account details. Press 2 to reach one of our agents. Press 3 for complaints. Press 5 to exit' do
      match 1 do

        input = ask "Please enter your DNI. After that, press the # key", :limit => 9, :terminator => "#", :timeout => 30

        case input.status
          when :match
            say input.utterance.gsub(/[#]$/, "")
          when :nomatch
            say 'The input is not valid.'
            hangup
          when :noinput
            say 'No input was entered.'
            hangup
        end
      end

      match 2 do
        # call agent
        dial "user/1000"
      end

      match 3 do
        # complaints
        say 'Please, leave a message after the beep.'
        result = record timeout: 30
        puts "Recorded file: #{result.recording_uri}"
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
