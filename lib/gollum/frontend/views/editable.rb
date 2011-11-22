module Precious
  module Editable
    def formats(selected = @page.format)
      [ { :name => "Markdown", :id => "markdown", :selected => true } ]
    end
  end
end
