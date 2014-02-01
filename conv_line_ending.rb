#!/usr/bin/ruby

require 'find'

DIRS = %w(
	app 
	config 
	aux 
	lib 
	script
)

IGNORE = %w(
	app/assets/javascripts/legado/lib/ckeditor
	app/assets/stylesheets/legado/tn3skins
	app/assets/javascripts/legado/lib/jshashtable-2.1_src.js
	app/assets/javascripts/legado/lib/jquery17/jquery.numberformatter-1.2.3.js
	app/assets/javascripts/legado/lib/flot07/unused/jquery.flot.pie.js
)

def is_rn(path)
	File.open(path) do |file|
		prev_is_r = false
	    file.each_byte do |b|
	    	case b.chr
	    	when "\r"
	    		prev_is_r = true
		    when "\n"
		    	return true if prev_is_r
		    else
		    	prev_is_r = false if prev_is_r
		    end
	    end
	end
	false
end

def _unixilize(path)
	buffer = nil
	File.open(path, 'r'){|f| buffer = f.read}
	bk = "#{path}_#{(rand 1e20).to_s}"
	File.open(bk, 'w'){|f| f.write buffer}
	begin
		File.open(path, 'w'){|f| f.write buffer.gsub!("\r\n", "\n")}
		File.delete bk
	rescue Exception => e
		puts e.message
	end
	puts "#{path} converted successfully."
end

def unixilize(res, idx = nil)
	if idx.nil? # all
		res.each{|r| _unixilize r}
	else
		_unixilize res[idx]
	end
end

res = []

DIRS.each do |dir|
	Find.find dir do |path|
		if IGNORE.include? path
			if File.directory? path
				Find.prune
			else
				next
			end
		end

		next if File.directory? path

		next unless path =~ /\.(rb|html?|js|css|erb|rake|sh)$/i

		res << path if is_rn path
	end
end

if res.size > 0

	puts "\n"

	res.each_with_index{|r, idx| puts "#{idx+1} #{r}"}

	puts "\nFound #{res.size} files containing \\r\\n."
	puts "Convert \\r\\n to \\n for:"

	while true do
		puts "\n\na\tall\n<n>\tfile <n>\nq\tquit\n\n"

		print "(a)? "

		command = gets.chomp

		case command
		when "a"
			unixilize res
			exit
		when /^\d+$/
			if res[command.to_i-1]
				unixilize res, command.to_i-1
			else
				puts "invalid command.\n"
			end 
		when "q"
			puts ""
			exit
		else
			puts "invalid command.\n"
		end
	end

else

	puts "\\r\\n not found in files."

end


