require File.dirname(__FILE__) + '/lib/paginate'
require File.dirname(__FILE__) + '/lib/view_helper'

Array.send :include, SimplePaginate::Paginate
ActiveRecord::Relation.send :include, SimplePaginate::Paginate
ActiveRecord::Associations::AssociationCollection.send :delegate, :paginate, :more?, :to=>:scoped
ActiveRecord::Base.class_eval do
  class << self
    delegate :paginate, :more?, :to=>:scoped
  end
end
ActionView::Base.send :include, SimplePaginate::ViewHelper