class AccountMenuController < Adhearsion::CallController
  def run
    input = ask "Please enter your DNI. After that, press the # key", :limit => 9, :terminator => "#", :timeout => 30

    case input.status
      when :match
        account = DB[:accounts][dni: input.utterance.gsub(/[#]$/, "")]
        
        output_details account
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

  def bye
    say 'Good bye.'
    hangup
  end
end
