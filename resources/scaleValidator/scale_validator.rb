#!/usr/bin/ruby

if (ARGV[0] == nil)
	puts "\e[31mError\e[0m: no input scale."
	puts "Usage: ./scale_validation.rb <scale>"
	puts "Help: ./scale_validation.rb --help"
	exit 1
end

if (ARGV[0] == "--help")
	puts "****************\n|     \e[1mHELP\e[0m     |\n****************\n"
	puts "\nUsage: ./scale_validation.rb <scale>"
	puts "\nPlease install gem needed with the following command :"
	puts "	\e[1mgem install --user kwalify\e[0m"
	puts "\nThe scale validator will check 4 types of error in your scale."
	puts "\e[4mError1\e[0m: \e[1mSyntax Error\e[0m: format => \e[31mError\e[0m: file: line: message"
	puts "\e[4mError2\e[0m: \e[1mSheme Error\e[0m: format => \e[31mError\e[0m: path/to/your/error/in/sheme: message"
	puts "\e[4mError3\e[0m: \e[1mWrong position\e[0m: format => \e[31mError\e[0m: invalid position argument in [section]"
	puts "\e[4mError4\e[0m: \e[1mNot enough skill point\e[0m: format => \e[31mError\e[0m: total percentage for [skill] is [value]"
	puts "	For this error, please refer to the summary of points by section."
	puts "	\e[1m\e[33mNumber\e[0m is too low"
	puts "	\e[1m\e[31mNumber\e[0m is too high"
	puts "	\e[1m\e[32mNumber\e[0m is ok"

	exit 1
end

# you need the gem below, a "gem install kwalify" will do the trick
require 'kwalify'
require 'yaml'

$exit_status = 0

############################## VALIDATION SCHEMA ###############################
begin
	schema = {"type" => "map", 
			"mapping" => { "name" => {"type"=>"str", "required"=>true},
			"is_primary"=>{"type"=>"bool", "required"=>true},
			"lg"=>{"type"=>"str", "required"=>true, "enum"=>["fr", "en", "ro"]},
			"comment"=>{"type"=>"str", "required"=>true}, 
			"introduction_md"=>{"type"=>"str", "required"=>true}, 
			"disclaimer_md"=>{"type"=>"str", "required"=>true}, 
			"guidelines_md"=>{"type"=>"str", "required"=>true, "assert"=>"val != ''"},
			"correction_number"=>{"type"=>"int", "required"=>true}, 
			"duration"=>{"type"=>"int", "required"=>true},
			"flag_ids"=>{"type"=>"seq", "required"=>true, "sequence"=>[{"type"=>"int", "required"=>true}]},  
			"sections"=>{"type"=>"seq", "required"=>true, "sequence"=>[{"type"=>"map", "required"=>true, "mapping"=>{"name"=>{"type"=>"str", "required"=>true, "assert"=>"val != ''"},
			"position"=>{"type"=>"int", "required"=>true}, 
			"description"=>{"type"=>"str", "required"=>true}, 
			"questions"=>{"type"=>"seq", "required"=>true, "sequence"=>[{"type"=>"map", "required"=>true, "mapping"=>{"name"=>{"type"=>"str", "required"=>true, "assert"=>"val != ''"}, 
			"position"=>{"type"=>"int"}, "guidelines"=>{"type"=>"str", "required"=>true, "assert"=>"val != ''"}, "rating"=>{"type"=>"str", "required"=>true, "enum"=>["bool", "multi"]}, 
			"kind"=>{"type"=>"str", "required"=>true, "enum"=>["standard", "bonus"]}, 
			"questions_skills"=>{"type"=>"seq", "required"=>true, "sequence"=>[{"type"=>"map", "required"=>true, "mapping"=>{"percentage"=>{"type"=>"int", "required"=>true}, 
			"name"=>{"type"=>"str", "required"=>true, "enum"=>["Unix", "Web", "Imperative programming", "Rigor", "Graphics", "Functional programming", "Parallel computing", "Network & system administration", "Security", "DB & Data", "Organization", "Adaptation & creativity", "Company experience", "Object-oriented programming", "Group & interpersonal", "Technology integration", "Algorithms & AI", "Ruby", "Shell", "Motion Design"]}}}]}}}]}}}]}}}

	validator = Kwalify::Validator.new(schema)
	document = YAML.load_file(ARGV[0])
	errors = validator.validate(document)
	if errors && !errors.empty?
		for e in errors
			puts "\e[31mError\e[0m: in \e[1m\e[33m#{e.path}\e[0m: #{e.message}"
		end
		$exit_status = 1
		exit $exit_status
	end

rescue Psych::SyntaxError  => e
	$stderr.print "\e[31mError\e[0m: #{e.file}: line #{e.line}: #{e.message} \n"
	$exit_status = 1
	exit $exit_status
end


################################################################################


############################## VALIDATION INFOS ################################

$project_skills = Hash.new(0)
$project_bonus = Hash.new(0)
$bonus = false

def add_skills(skill_type, q_skills)
	q_skills.each do |skill| 

		if (skill['percentage'] != nil) 

			then skill_type[skill['name']] += skill['percentage']
			if (($bonus == true and skill_type[skill['name']] < 25) or ($bonus == false and skill_type[skill['name']] < 100))
				puts "          #{skill['name']}: \e[1m#{skill['percentage']}\e[0m => \e[1m\e[33m#{skill_type[skill['name']]}\e[0m\n"
			elsif (($bonus == true and skill_type[skill['name']] > 25) or ($bonus == false and skill_type[skill['name']] > 100))
				puts "          #{skill['name']}: \e[1m#{skill['percentage']}\e[0m => \e[1m\e[31m#{skill_type[skill['name']]}\e[0m\n"
			else
				puts "          #{skill['name']}: \e[1m#{skill['percentage']}\e[0m => \e[1m\e[32m#{skill_type[skill['name']]}\e[0m\n"
			end

		end

	end
end

def questions_inspect(questions)
	position = 1
	current_position_question = 1
	questions.each do |question|
		puts "     \e[4m#{question['name']}\e[0m"
		position = question['position']
		if (position != current_position_question)
			$stderr.print "\e[31mError\e[0m: invalid position argument in question [#{question['name']}]:\n"
			$exit_status = 1
		end
		current_position_question += 1
		if (question['kind'] == "standard")
			add_skills $project_skills, question['questions_skills']
		elsif (question['kind'] == "bonus")
			$bonus = true
			add_skills $project_bonus, question['questions_skills']
		end
	end
end

position = 1
current_position_sec = 1
document['sections'].each do |sec| 
	puts "\e[1m#{sec['name']}\e[0m"
	position = sec['position']
	if (position != current_position_sec)
		$stderr.print "\e[31mError\e[0m: invalid position argument in section [#{sec['name']}]\n"
		$exit_status = 1
	end
	current_position_sec += 1
	questions_inspect(sec['questions'])
end

$project_skills.each do |skill, value| 
	if value != 100
		puts "\e[31mError\e[0m: total percentage for #{skill} is #{value}"
		$exit_status = 1
	end
end

$project_bonus.each do |skill, value|
	if value > 25
		puts "\e[31mError\e[0m: total percentage of bonus for #{skill} is #{value}"
		$exit_status = 1
	end
end

if $exit_status == 0
	puts "\n\e[32mall good\e[0m: #{ARGV[0]} is now \e[32mvalid\e[0m !"
else
	puts "\e[31mError\e[0m: something's wrong with your scale. Fix it, then try again."
end

exit $exit_status
