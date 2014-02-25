#!/usr/bin/env ruby
#
# Generate a custom markdown file
#

require 'pathname'

$here = File.expand_path(File.dirname(__FILE__))
$root = $here

def get_src(url, path)
    cmd = "hg clone #{url} #{path}"
    print cmd
    system(cmd)
end

def update_src(path)
    cmd = "hg pull -u -R #{path}"
    print cmd
    system(cmd)
end

def generate(src, dst)
    print "generate #{src} #{dst}\n"
    output = File.open(dst, 'w')
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
                get_src(link, program_path)
            else
                update_src(program_path)
            end
            import_link_str = "https://mbed.org/compiler/#import:" + link
            output.write("**#{name}** - [Import to mbed online compiler](#{import_link_str})\n")
            output.write( "```\n")
            output.write(File.open(main_cpp).read())
            output.write("\n```\n")
        else
            output.write(line)
        end
    end
end

print "update markdown files\n"
system("mkdir -p #$root/programs")
Dir["#$root/en/*/*.md"].sort.map do |src_file|
    dst_file = src_file.clone
    dst_file.sub! ".md", ".markdown"
	generate(src_file, dst_file)
end



