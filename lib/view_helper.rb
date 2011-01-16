module SimplePaginate
  module ViewHelper
    
    def see_more resources, next_path={}
      next_path = case next_path
        when String
          next_path
        when Hash
          next_path.merge(:page => resources.page + 1)
        else
          polymorphic_path(next_path, :page => resources.page + 1)
        end
      
      if resources.count > 0
        if resources.more?
          content_tag :div,
                      link_to(t('.see_more', :default=>t('see_more', :default=>'See more')), next_path, { :remote=>true }),
                      :class=>:paginate
        end
      else
        content_tag :div, t('.no_results', :default=>t('no_results', :default=>'No results')), :class=>:paginate
      end
    end
    
  end
end