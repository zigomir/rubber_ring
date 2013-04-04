class SiteController < ApplicationController
  def home
    key_prefix = [params[:controller], params[:action], ''].join('_').to_sym
    p key_prefix

    # here load all the values for this action
    # this is fake data
    @content = {
      #:'site_home_key' => I18n.t('site_home_key')
      :'site_home_key' => 'test editable text content'
    }
  end
end
