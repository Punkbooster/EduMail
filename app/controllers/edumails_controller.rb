class EdumailsController < ApplicationController
  before_action :find_edumail, only: [:show,:update,:edit,:destroy]
  before_filter :authenticate_user!

  def index
    @edumails=Edumail.all
    @edumail=Edumail.where(email: current_user.email).order('updated_at DESC').first
  end

  def new
    @edumail=Edumail.new
  end

  def create
    @edumail=Edumail.create
    @edumail.status="Pending"
    @edumail.user_id=current_user.id
    @edumail.email= current_user.email
    if @edumail.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show

  end

  def update
    if @edumail.update(edumail_params)
      redirect_to root_path
    else
      render "edit"
    end

  end

  def edit

  end

  def destroy

  end

  private

  def edumail_params
    params.require(:edumail).permit(:edu_mail,:edu_password,:status)
  end

  def find_edumail
    @edumail = Edumail.find(params[:id])
  end
end
