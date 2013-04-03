class Admin::CmsController < ApplicationController

  def save
    key   = params[:prefix] + params[:value].parameterize[0..20]
    value = params[:value]

    # TODO store with HSTORE http://railscasts.com/episodes/345-hstore
    # or Gdoc?
    render :json => { key: key, value: value }
  end

end
