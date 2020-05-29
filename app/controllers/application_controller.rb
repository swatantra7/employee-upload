class ApplicationController < ActionController::Base

  def xhr_redirect_to(args)
    @args = args
    flash.keep
    render 'shared/xhr_redirect_to'
  end

end
