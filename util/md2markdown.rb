#!/usr/bin/env ruby
#
# Generate a custom markdown file
#

require 'pathname'

$here = File.expand_path(File.dirname(__FILE__))
$root = File.join($here, '..')

def fetch_code(url, path)
    cmd = "hg clone #{url} #{path}"
    print "Running: #{cmd}\n"
    system(cmd)
    print "Done"
end

def update_code(path)
    cmd = "hg pull -u -R #{path}"
    print "Running: #{cmd}\n"
    system(cmd)
    print "Done"
end

def convert(src)
    output = String.new()
    File.open(src, 'r').each do |line|
        if line.include? '[!program]'
            link_path = Pathname.new('mbed.org')
            relative_path = line[/.*\(([^\)]*)/, 1]
            link_path = link_path.join(relative_path)
            link = 'https://' + link_path.to_s
            name = link_path.basename
            program_path = "#$root/programs/#{name}"
            main_cpp = "#{program_path}/main.cpp"
            if not Pathname.new(main_cpp).exist?
                fetch_code(link, program_path)
            else
                # update_code(program_path)
            end
            import_link_str = "https://mbed.org/compiler/#import:" + link

            output << "**#{name}** - [Import to mbed online compiler](#{import_link_str})\n"
            output << "\n~~~~{.cpp}\n"
            output << File.open(main_cpp).read()
            output << "\n~~~~\n"
        else
            output << line
        end
    end
    output << "\n\n"
end

print "Generate a custom markdown file\n"
system("mkdir -p #$root/programs")
markdown = File.open("#$root/archcookbook.en.markdown", 'w')
Dir["#$root/en/*.md"].sort.map do |file|
    markdown.write(convert(file))
end



