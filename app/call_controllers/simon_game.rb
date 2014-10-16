# encoding: utf-8

require 'sequel'
DB = Sequel.sqlite :database => File.join(Adhearsion.root, "accounts.db")

class RubyConf < Adhearsion::CallController

  def run
    answer

    # menu 'Bienvenido al servicio de atencion al cliente del banco Adhearsion Rio'
    #      'Marque 1 para conocer el estado de su cuenta' => "Query+Play"
    #      'Marque 2 para ser atendido por uno de nuestros representantes' => "Dial"
    #      'Marque 3 por quejas y reclamos' => "Record"

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
        account_menu
        get_to_main
      end

      match 2 do
        dial "user/1000"
      end

      match 3 do
        result = record timeout: 30
        puts "Recorded file: #{result.recording_uri}"
      end

      match 5 do
        bye
      end

      invalid do
        @tries += 1
        say 'The option you have entered is not valid.'
      end
    end
  end

  def account_menu
    input = ask "Please enter your DNI. After that, press the # key", :limit => 9, :terminator => "#", :timeout => 30

    case input.status
      when :match
        account = DB[:accounts][dni: input.utterance.gsub(/[#]$/, "")]
        
        output_details account
        # play '/var/lib/freeswitch/storage/1up.wav'
        # say 'Your account is empty.'
      when :nomatch
        say 'The input is not valid.'
        bye
      when :noinput
        say 'No input was entered.'
        bye
    end
  end

  def output_details(account)
    say "Hello #{account[:name]}"
    say "You have #{account[:balance]} on your account."
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

end
