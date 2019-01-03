class UserinfosController < ApplicationController
	def new
  	@userinfo = UserInfo.new
  end


  def create
  	@userinfo = UserInfo.new(userinfo_params)
 	  @userinfo.save
	  redirect_to user_path(current_user.id)
  end


  def edit

  end

  def update 
    redirect_to user_path(current_user.id)
  end

  def delete
    
  end


end
