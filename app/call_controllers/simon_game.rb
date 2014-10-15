# encoding: utf-8

class RubyConf < Adhearsion::CallController

  def run
    answer

    # menu 'Bienvenido al servicio de atencion al cliente del banco Adhearsion Rio'
    #      'Marque 1 para conocer el estado de su cuenta' => "Query+Play"
    #      'Marque 2 para ser atendido por uno de nuestros representantes' => "Dial"
    #      'Marque 3 por quejas y reclamos' => "Record"

    menu '/var/lib/freeswitch/storage/demo.wav' do
      match 1 do
        play '/var/lib/freeswitch/storage/1up.wav'
      end

      match 2 do
        dial "user/1000"
      end

      match 3 do
        result = record timeout: 30
        puts "Recorded file: #{result.recording_uri}"
      end

      invalid do
        hangup
      end
    end
    hangup
  end

end
