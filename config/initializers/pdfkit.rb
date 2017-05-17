PDFKit.configure do |config|
	if ['development'].include?(Rails.env)
		#only if your are working on 32bit machine
		config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-i386.exe').to_s
	else
		#if your site is hosted on heroku or any other hosting server which is 64bit
		config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s
	end
end