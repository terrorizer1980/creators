class LogToHipchatJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    joblog "LogToHipChat:\t"
    joblog message
    
    begin
      if defined? HIPCHAT
        if HIPCHAT[:enabled]
          HIPCHAT_CLIENT[HIPCHAT[:room_name]].send(HIPCHAT[:user_name], message)
        end
      end
    rescue => ex
      joblog '*** something went wrong trying to send your hipchat message:' + ex.message
    end
  end
end
