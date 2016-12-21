ActiveJob::Base.queue_adapter = :delayed_job

if Rails.env == "development" 
 	class JobLogger < Logger 
 		def format_message(severity, timestamp, progname, msg) "#{msg}\n" 
 		end 
 	end 
 	logfile = File.open(Rails.root + 'log/job.log', File::WRONLY|File::APPEND|File::CREAT, 0666) 
 	logfile.sync = true 
 	Jlog = JobLogger.new(logfile) 
 	class Object 
 		def joblog(mssg) 
 			Jlog.info(mssg) 
 		end 
 	end 
else 
 	class Object 
 		def joblog(mssg) 
 		end 
 	end 
end