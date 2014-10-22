# encoding: utf-8

class MainController < Adhearsion::CallController

  before_call :filter

  def run
    answer

    hangup
  end

  def filter
    reject if call.from =~ /^11/
  end
end
