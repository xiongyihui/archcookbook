#!/usr/bin/env ruby
# Invoke with `ruby md2cre.rb filename.md`
#
# for Ubuntu: `sudo apt-get install ruby ruby1.9.1-dev  # ruby{x.x.x}-dev`
#             `gem install redcarpet`


require 'rubygems'
require 'redcarpet'
require 'pathname'

$here = File.expand_path(File.dirname(__FILE__))
$root = File.join($here, '..')

class Creole < Redcarpet::Render::Base
  def normal_text(text)
    text
  end

  def link(link, title, content)
    case content
    when "!program"
      program = Pathname.new(link)
      program = program.join('docs/default/main_8cpp_source.html')
      "<<program /#{program}>>"
    when "!library"
      "<<library #{link}>>"
    else
      "[[#{link} | #{content}]]"
    end
  end

  def image(link, title, alt_text)
    "{{#{link} | #{title}}}"
  end

  def block_code(code, language)
    "\n<<code>>\n#{normal_text(code)}<</code>>\n"
  end

  def codespan(code)
    block_code(code, nil)
  end

  def header(title, level, anchor)
    case level
    when 1
      "\n= #{title} =\n"

    when 2
      "\n== #{title} ==\n"

    when 3
      "\n=== #{title} ===\n"

    when 4
      "\n==== #{title} ====\n"
    end
  end

  def double_emphasis(text)
    "**#{text}**"
  end

  def emphasis(text)
    "//#{text}//"
  end

  def strikethrough(text)
    ""
  end

  def superscript(text)
    "^^${text}^^"
  end

  def underline(text)
    "__#{text}__"
  end

  def highlight(text)
    "###{text}##"
  end

  def quote(text)
    "\n<<quote>>\n#{text}\n<</quote>>\n"
  end

  def linebreak
    "\n"
  end

  def paragraph(text)
    "\n#{text}\n"
  end

  def list(content, list_type)
    case list_type
    when :ordered
      "\n#{content}\n"
    when :unordered
      "\n#{content}\n"
    end
  end

  def list_item(content, list_type)
    case list_type
    when :ordered
      "##{content.strip}\n"
    when :unordered
      "*#{content.strip}\n"
    end
  end
end

markdown = Redcarpet::Markdown.new(Creole, :fenced_code_blocks => true)
output = File.open("#$root/archcookbook.en.wiki", 'w')
Dir["#$root/en/*.md"].sort.map do |file|
    output.write(markdown.render(File.read(file)))
end

