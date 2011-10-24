require 'fileutils'
require 'shellwords'
require 'tmpdir'

module Gollum
  module Tex
    Template = <<-EOS
\\documentclass[12pt]{article}
\\usepackage{color}
\\usepackage[dvips]{graphicx}
\\pagestyle{empty}
\\pagecolor{white}
\\begin{document}
{\\color{black}
\\begin{eqnarray*}
%s
\\end{eqnarray*}}
\\end{document}
    EOS

    class << self
      attr_accessor :latex_path, :dvips_path, :convert_path
    end

    self.latex_path   = 'latex'
    self.dvips_path   = 'dvips'
    self.convert_path = 'convert'

    def self.check_dependencies!
      if `which latex` == ""
        raise "`latex` command not found"
      end

      if `which dvips` == ""
        raise "`dvips` command not found"
      end

      if `which convert` == ""
        raise "`convert` command not found"
      end
    end

    def self.render_formula(formula)
      check_dependencies!

      Dir.mktmpdir('tex') do |path|
        tex_path = ::File.join(path, 'formula.tex')
        dvi_path = ::File.join(path, 'formula.dvi')
        eps_path = ::File.join(path, 'formula.eps')
        png_path = ::File.join(path, 'formula.png')

        ::File.open(tex_path, 'w') { |f| f.write(Template % formula) }

        sh latex_path, '-interaction=batchmode', 'formula.tex', :cwd => path
        sh dvips_path, '-o', eps_path, '-E', dvi_path
        sh convert_path, '+adjoin',
          '-antialias',
          '-transparent', 'white',
          '-density', '150x150',
          eps_path, png_path

        ::File.read(png_path)
      end
    end

    private
      def self.sh(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        cwd     = "cd \"#{options[:cwd]}\" && " if options[:cwd]
        `#{cwd}#{Shellwords.join(args)} 2>&1`
      end
  end
end