module SimplePaginate
  module Paginate

    # Performs pagination. Accepts :per_page and :page arguments.
    # A PER_PAGE constant can be defined in the model.
    def paginate options={}
      page     = (options[:page] || 1).to_i
      per_page = (options[:per_page] || (defined?(PER_PAGE) ? PER_PAGE : (defined?(@klass::PER_PAGE) ? @klass::PER_PAGE : 10))).to_i
      
      output = if self.is_a?(Array)
          self[(page-1) * per_page...((page-1) * per_page+per_page)]
        else
          limit(per_page).offset((page-1) * per_page)
        end
      
      output.page = page
      output.per_page = per_page
      output.backchain = self
      output
    end
    
    # Returns true if there are more pages with results.
    # It's a way to check if we are on the last page.
    def more?
      backchain.count > per_page * page
    end
    
    def page;             @page;              end
    def page= value;      @page = value;      end
    def per_page;         @per_page;          end
    def per_page= value;  @per_page = value;  end
    def backchain;        @backchain;         end
    def backchain= value; @backchain = value; end

  end
end