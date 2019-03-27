#
class Landing::WelcomeController < Landing::BaseController
  def root
    set_meta_tags default_meta_tags
    render layout: '../landing/layout'
  end

  def terms
    set_meta_tags default_meta_tags
    render layout: '../landing/layout'
  end
end
