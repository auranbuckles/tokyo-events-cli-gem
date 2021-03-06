class TokyoEvents::CLI

	def run
		TokyoEvents::Scraper.scrape_and_create_events
		list_events
		choose_event
	end

	def list_events
		puts ""
		puts "============ Upcoming events ============"
		puts ""
		TokyoEvents::Event.all.each.with_index(1) do |event, i|
			puts "#{i}. #{event.name} - #{event.dates}"
		end
		puts ""
		puts "========================================="
		puts ""
	end

	def choose_event
		input = nil
		while input != "exit"
			puts ""
			puts "Which event would you like to learn more about?"
			puts ""
			puts "Enter an index number or keyword to view details of specific events."
			puts "Enter list to see all the events again."
			puts "Enter exit to exit the program."
			puts ""
			input = gets.strip
			if input == "list"
				list_events
			elsif input.to_i == 0 && input != "exit"
				if results = TokyoEvents::Event.find_by_name(input)
          results.each.with_index(1) do |event, i|
          	puts ""
		        puts "============================= Result #{i} ============================="
		        puts ""
		        show_event(event)
		      end
        end
      elsif input.to_i > 0
      	if event = TokyoEvents::Event.find(input.to_i - 1)
          show_event(event)
        end
			end
		end
		goodbye
	end

	def show_event(event)
		puts "------------ #{event.name} ------------"
		puts ""
		puts "Date(s): #{event.dates}"
		puts "Location: #{event.location}"
		puts "Link: #{event.url}"
		puts ""
		puts "------------ Description ------------"
		puts ""
		puts "#{event.description}"
		puts ""
		puts "-------------------------------------"
		puts ""
	end

	def goodbye
		puts "Goodbye!"
	end

end